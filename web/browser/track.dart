library track;

import 'dart:html';
import 'dart:svg';
import 'package:polymer/polymer.dart';

/*
 * A track in the Uvaro browser
 */
@CustomTag('uvaro-track')
class UvaroTrack extends PolymerElement {
  @published String sourcePath;
  @published String seqName;
  @published int seqLength;
  @published int seqStart;
  @published int seqStop;
  @observable double bpPerPixel;
  List<Gene> geneList = toObservable([]);
  
  UvaroTrack.created() : super.created();

  @override
  void enteredView() {
    window.onResize.listen((e) {
      print("seqStop = $seqStop");
      print("seqStart = $seqStart");
      bpPerPixel = (seqStop - seqStart) / $['svgCanvas'].clientWidth;
    });

    geneList.add(new Gene.pos("Gene1", 20, 89));
    geneList.add(new Gene.pos("Gene1", 145, 80));
    geneList.add(new Gene.pos("Gene1", 250, 5));
    geneList.add(new Gene.pos("Gene1", 657, 162));
    geneList.add(new Gene.pos("Gene1", 873, 90));
  }

  void seqStartChanged(old) {
    bpPerPixel = (seqStop - seqStart) / $['svgCanvas'].clientWidth;
  }
  
  void seqStopChanged(old) {
    bpPerPixel = (seqStop - seqStart) / $['svgCanvas'].clientWidth;
  }
}


@CustomTag('uvaro-gene')
class Gene {
  String id;
  int geneStart;
  int geneLength;
  bool strand = true;
  
  Gene(this.id, this.geneStart, this.geneLength, this.strand);
  Gene.pos(String id, int geneStart, int geneLength) : this(id, geneStart, geneLength, true);
  Gene.neg(String id, int geneStart, int geneLength) : this(id, geneStart, geneLength, false);
}
