library browser;

import 'dart:html';
import 'track.dart';
import 'package:polymer/polymer.dart';

/**
 * Rough sketches of a genome browser build on web components.
 */
@CustomTag('uvaro-browser')
class UvaroBrowser extends PolymerElement {
  @observable String seqName;
  @observable int seqStart;
  @observable int seqStop;
  @observable int seqWidth;
  @observable int seqLength;
  List<UvaroTrack> trackList = toObservable([]);
  UvaroBrowser.created() : super.created();
  
  @override
  void enteredView() {
    setupSelector("scaffold_001");
    $['addButton'].onClick.listen(addTrack);
    // Move the track from light DOM to dark.
    querySelectorAll('uvaro-track').forEach((UvaroTrack track){
      trackList.add(track);
      track.remove();
    });
    renderall();
  }
  
  void renderall() {
    trackList.forEach((UvaroTrack track) {
      track.seqStart = seqStart;
      track.seqStop = seqStop;
      track.render();
    });
  }
  
  void seqStartChanged() {
    window.animationFrame.then((_) {
      renderall();
    });
  }
  
  void seqStopChanged() {
    window.animationFrame.then((_) {
      renderall();
    });
  }
  
  void setupSelector(String seqName) {
    // TODO Read sequence lengths from fasta file (or gff3).
    this.seqName = seqName;
    this.seqLength = 1000;
    
    window.onResize.listen((Event e) {
      $['subsequence-selector'].refreshWidths(e);
    });
  }
  
  void addTrack(MouseEvent e) {
    UvaroTrack newTrack =  new Element.tag('uvaro-track')
    ..sourcePath = 'new/track/source.gff3';
    trackList.add(newTrack);
  }
}