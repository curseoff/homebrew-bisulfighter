class Bisulfighter < Formula
  homepage "http://epigenome.cbrc.jp/bisulfighter/"
  url "https://github.com/yutaka-saito/Bisulfighter/archive/master.zip"
  version "20150929"
  sha256 "b25191d24c26f1a60d9dce95261691f57a6369eb13cc31a3ccf57c6d046de869"

  depends_on "boost"
  depends_on "mtoutai/last/last"

  def install
    Dir.chdir "ComMet"
    system "make"
    bin.mkpath
    Dir.chdir ".."
    bin.install "bsf-call/bsf-call"
    bin.install "bsf-call/bsfcall.py"
    bin.install "ComMet/src/ComMet"
    bin.install "ComMet/util/Bsf2ComMetIn.pl"
    bin.install "ComMet/util/Bsf2ComMetInFw.pl"
    bin.install "ComMet/util/Bsf2ComMetInRv.pl"
    bin.install "ComMet/util/ComMetOut2Bsf.pl"
    bin.install "ComMet/util/ComMetOut2BsfFw.pl"
    bin.install "ComMet/util/ComMetOut2BsfRv.pl"
    prefix.install "script"
    prefix.install "ComMet/README" => "README.ComMet"
    prefix.install "README.txt"
    prefix.install "demo"
  end

  stable do
    patch :DATA
  end

  bottle do
    root_url "https://github.com/mtoutai/homebrew-bisulfighter/releases/download/bottles"
    cellar :any
    sha256 "a87a4f8a711a0e39e429538adefec59cd83da9198fd2f18395aa00ec58d5a108" => :yosemite
    revision 1
    sha256 "ad66d481de1f6442c93d05dabc41b2a7353e68b0ec8f561cbf33f5667056d367" => :el_capitan
  end

end
