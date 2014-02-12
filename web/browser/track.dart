library track;

import 'dart:html';
import 'dart:svg';
import 'package:polymer/polymer.dart';

/**
 * A track in the Uvaro browser
 */
@CustomTag('uvaro-track')
class UvaroTrack extends PolymerElement {
  @published String sourcePath;
  @published String seqName;
  @published int seqLength;
  @published int seqStart;
  @published int seqStop;
  
  List<Gene> geneList = toObservable([]);
  
  int _canvasWidth;
  
  GElement trackGroup;
  
  UvaroTrack.created() : super.created();
  
  @override
  void enteredView() {
    _canvasWidth = $['trackCanvas'].clientWidth;

    geneList.add(new Gene('gene1', 100, 200, true));
    geneList.add(new Gene('gene2', 250, 312, true));
    geneList.add(new Gene('gene3', 362, 400, true));
    geneList.add(new Gene('gene4', 480, 600, true));
  }
  
  void render() {
    // Scale factor needs to be in pixels per bp
    print("  _canvasWidth = $_canvasWidth, seqStart = $seqStart, seqStop = $seqStop");
    var scaleFactor = _canvasWidth / (seqStop - seqStart);
    print("  scaleFactor = $scaleFactor");
    //$['trackGroup'].attributes["transform"] = "translate(-${seqStart * scaleFactor} 0)";
    GElement trackGroup = $['trackGroup'];
    geneList.forEach((Gene gene) {
      gene.draw(trackGroup, scaleFactor);
    });
    print("  render end. trackGroup has ${trackGroup.children.length} children");
  }
}

class Gene {
  String id;
  int startPosition;
  int stopPosition;
  bool strand;
  
  Gene(this.id, this.startPosition, this.stopPosition, this.strand);
  
  void draw(GElement trackGroup, double scaleFactor) {
    RectElement geneRect;
    geneRect = trackGroup.querySelector('#$id');
    if(geneRect != null) {
      geneRect.remove();
    }
    geneRect = new RectElement()
    ..id = id
    ..height.baseVal.value = 15
    ..y.baseVal.value = 0
    ..x.baseVal.value = startPosition / scaleFactor
    ..width.baseVal.value = (stopPosition - startPosition) / scaleFactor;
    trackGroup.children.add(geneRect);
  }
}
