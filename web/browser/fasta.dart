library fastaConversion;

import 'dart:convert';

class FastaConverter extends Converter<String, List<String>> {
  
  const FastaConverter();
  
  List<String> convert(String input) {
    print("FastaConverter convert() string of length ${input.length}");
    return input.split(">");
  }
  
  FastaSink startChunkedConversion(sink) {
    return new FastaSink(sink);
  }
}

class FastaSink extends ChunkedConversionSink<String> {
  final _converter;
  final ChunkedConversionSink<List<String>> _outSink;
  
  FastaSink(this._outSink) : _converter = new FastaConverter();
  
  void add(String chunk) {
    print("adding chunk of length ${chunk.length}");
    _outSink.add(_converter.convert(data));
  }

  void close() {
    _outSink.close();
  }
}
