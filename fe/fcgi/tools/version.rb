apt = proc{|package|
  info = `dpkg -s #{package}`
  ver = info[/Version: (\d:)?(.*)/, 2]
  r = "Debian package: #{package}-" + ver
  if info =~ /^Homepage: (.*)/
    r += " (#{$1})"
  end
  r
}

LANGS = {
  'rb' => [apt['ruby1.8']],
  'pl' => [apt['perl']],
  'py' => [apt['python']],
  'php' => [apt['php5-cli']],
  'scm' => [apt['gauche']],
  'l' => [apt['clisp']],
  'arc' => ['arc3.tar (http://arclanguage.org/)'],
  'ly' => [apt['lilypond']],
  'io' => ['Io 20080209 (http://iolanguage.com/)'],
  'js' => [apt['spidermonkey-bin']],
  'lua' => [apt['lua5.1']],
  'tcl' => [apt['tcl8.5']],
  'xtal' => ['xtal 0.9.7.0 (http://code.google.com/p/xtal-language/)'],
  'kt' => ['This is kite, version 1.0.3 (http://www.kite-language.org/)'],
  'cy' => ['cyan-1.0.3.tgz (http://www.geocities.jp/takt0_h/cyan/index.html)'],
  'st' => [apt['gnu-smalltalk']],
  'pro' => [apt['swi-prolog']],
  'for' => [apt['gforth']],
  'bas' => [apt['yabasic']],
  'pl6' => ['This is Rakudo Perl 6. (http://rakudo.org/)'],
  'erl' => [apt['erlang']],
  'ijs' => ['j602 (http://www.jsoftware.com/)'],
  'a+' => [apt['aplus-fsf']],
  'mind' => ['Mind Version 7 for UNIX mind7u06.tar.gz (http://www.scripts-lab.co.jp/mind/whatsmind.html)'],
  'c' => [apt['gcc']],
  'cpp' => [apt['g++']],
  'd' => ['Digital Mars D Compiler v2.019 (http://www.digitalmars.com/d/)'],
  'di' => ['Digital Mars D Compiler v1.047 (http://www.digitalmars.com/d/)'],
  # cd /golf/local/go && hg log | head -4
  'go' => ['go changeset-4015:cb140bac9ab0 Nov 12 14:55:26 2009 -0800 (http://golang.org/)'],
  'ml' => [apt['ocaml']],
  'hs' => [apt['ghc6']],
  'adb' => [apt['gnat']],
  'm' => [apt['gobjc']],
  'java' => [apt['sun-java6-jdk']],
  'pas' => [apt['gpc']],
  'f95' => [apt['gfortran']],
  'cs' => [apt['mono-gmcs']],
  'n' => [apt['nemerle']],
  'cob' => [apt['open-cobol']],
  # cyc -v
  'curry' => ['cyc version 0.9.11 (built on Mon Jun 11 10:35:49 CEST 2007) (http://www.curry-language.org/)'],
  'lmn' => ['lmntal-20080828 (http://www.ueda.info.waseda.ac.jp/lmntal/pukiwiki.php?LMNtal)'],
  'max' => [apt['maxima']],
  'reb' => ['rebol-276 (http://www.rebol.com/)'],
  'asy' => [apt['asymptote']],
  'awk' => [apt['mawk']],
  'sed' => [apt['sed']],
  'sh' => [apt['bash']],
  'xgawk' => ['Extensible GNU Awk 3.1.6 (build 20080101) with dynamic loading, and with statically-linked extensions (http://sourceforge.net/projects/xmlgawk)'],
  'm4' => [apt['m4']],
  'ps' => [apt['ghostscript']],
  'r' => [apt['r-base']],
  'vhdl' => [apt['ghdl']],
  'qcl' => ['qcl-0.6.3 (http://tph.tuwien.ac.at/~oemer/qcl.html)'],
  'bf' => ['http://en.wikipedia.org/wiki/Brainfuck (http://en.wikipedia.org/wiki/Brainfuck)',
           'I think we are using <a href="http://esoteric.sange.fi/brainfuck/impl/interp/BFI.c">this C interpreter</a>, but I\'m not sure...'],
  'ws' => ['http://compsoc.dur.ac.uk/whitespace/ (http://compsoc.dur.ac.uk/whitespace/)',
           'We are using <a href="http://compsoc.dur.ac.uk/whitespace/downloads/wspace-0.3.tgz">the Haskell interpreter</a>.'],
  'bef' => ['http://catseye.tc/projects/bef/ (http://catseye.tc/projects/bef/)',
            'We are using <a href="http://catseye.tc/projects/bef-2.21.zip">the reference implementation</a>.'],
  'pef' => ['http://d.hatena.ne.jp/ku-ma-me/searchdiary?word=pefunge (http://d.hatena.ne.jp/ku-ma-me/searchdiary?word=pefunge)',
            'Pefunge is an esoteric language proposed by mame. There is only Japanese documentation about this language. <a href="http://dame.dyndns.org/misc/pefunge/2dpi.rb">The reference implementation</a>.'],
  'ms' => ['http://www.golfscript.com/minus/ (http://www.golfscript.com/minus/)',
           'Minus is an esoteric language, with only 1 instruction operator, invented by flagitious.'],
  'gs' => ['http://www.golfscript.com/golfscript/ (http://www.golfscript.com/golfscript/)',
           'GolfScript is a stack oriented esoteric language invented by flagitious.'],
  'unl' => ['http://www.madore.org/~david/programs/unlambda/ (http://www.madore.org/~david/programs/unlambda/)',
            'We are using <a href="http://www.math.cas.cz/~jerabek/unlambda/unl.c">the C interpreter</a> written by Emil Jerabek.'],
  'lazy' => ['http://homepages.cwi.nl/~tromp/cl/lazy-k.html (http://homepages.cwi.nl/~tromp/cl/lazy-k.html)',
             'We are using <a href="http://kiritanpo.dyndns.org/lazyk.c">the C interpreter</a> written by irori.'],
  'grass' => ['http://www.blue.sky.or.jp/grass/ (http://www.blue.sky.or.jp/grass/)',
              'We are using <a href="http://panathenaia.halfmoon.jp/alang/grass/grass.ml">the OCaml interpreter</a> written by YT.'],
  'lamb' => ['http://www.golfscript.com/lam/ (http://www.golfscript.com/lam/)',
             'Universal Lambda is proposed by flagitious. We are using <a href="http://kiritanpo.dyndns.org/clamb.c">the C interpreter written by irori</a>.'],
  'wr' => ['http://bigzaphod.org/whirl/ (http://bigzaphod.org/whirl/)',
           'We are using <a href="http://bigzaphod.org/whirl/whirl.cpp">the C++ interpreter</a>.'],
  's' => [apt['binutils']],
  'out' => [`uname -srvmo`],
  'z8b' => ['Modified fMSX (http://www.mokehehe.com/z80golf/)',
            'See <a href="http://sites.google.com/site/codegolfingtips/Home/z80">this site</a> for more detail.'],
  'com' => [apt['dosemu']],
  'class' => [apt['sun-java6-jre']],
  'vi' => [apt['vim']],
  'grb' => ['ruby 1.9.1p243 (2009-07-16 revision 24175) (http://ruby-lang.org/)'],
  'groovy' => [apt['groovy']],
  'clj' => ['Clojure 1.1.0 with clojure-contrib 1.1.0 (http://code.google.com/p/clojure/downloads/list)'],
}

LANGS.each do |l, info|
  version = info[0]
  version.gsub!(/http:\/\/[^)]+/, '<a href="\&">\&</a>')
  version += "<br>#{info[1]}" if info[1]
  puts "#{l} #{version}"
end

