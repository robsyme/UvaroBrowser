library browser;

import 'dart:html';
import 'track.dart';
import 'package:polymer/polymer.dart';

/**
 * Rough sketches of a genome browser build on web components.
 */
@CustomTag('uvaro-browser')
class UvaroBrowser extends PolymerElement {
  @observable int cursorPositionPx;
  @observable String seqName;
  @observable int seqStart;
  @observable int seqStop;
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
  }
  
  void setupSelector(String seqName) {
    // TODO Read sequence lengths from fasta file (or gff3).
    this.seqName = seqName;
    this.seqLength = 1000;
    this.seqStart = 1;
    this.seqStop = 999;
    
    window.onResize.listen((Event e) {
      $['subsequence-selector'].refreshWidths(e);
    });
  }
  
  void addTrack(MouseEvent e) {
    UvaroTrack newTrack =  new Element.tag('uvaro-track')
    ..sourcePath = 'new/track/source.gff3';
    trackList.add(newTrack);
  }
  
  void testMouseMove(MouseEvent e) {
    cursorPositionPx = e.offset.x;
  }
  
  void clearCursor(MouseEvent e) {
    cursorPositionPx = -1;
  }
}