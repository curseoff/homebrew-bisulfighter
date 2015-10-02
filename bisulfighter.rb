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

__END__
diff --git a/ComMet/src/GlobalStatistics.cc b/ComMet/src/GlobalStatistics.cc
index 8b48293..4877d42 100644
--- a/ComMet/src/GlobalStatistics.cc
+++ b/ComMet/src/GlobalStatistics.cc
@@ -872,10 +872,10 @@ GlobalStatistics::ValueType GlobalStatistics::
 pup_pseudo_count(float m1, float u1, float m2, float u2) const
 {
   const float pseudo = 8.0;
-  uint m1i = round(m1);
-  uint u1i = round(u1);
-  uint m2i = round(m2);
-  uint u2i = round(u2);
+  uint m1i = round_fu(m1);
+  uint u1i = round_fu(u1);
+  uint m2i = round_fu(m2);
+  uint u2i = round_fu(u2);
   ValueType q1up = (ValueType) (m1i + pseudo) / (m1i + pseudo + u1i); 
   ValueType q2up = (ValueType) m2i / (m2i + u2i + pseudo); 
   ValueType pup = log_binom(m1i, u1i, q1up) + log_binom(m2i, u2i, q2up);
@@ -888,10 +888,10 @@ GlobalStatistics::ValueType GlobalStatistics::
 pdown_pseudo_count(float m1, float u1, float m2, float u2) const
 {
   const float pseudo = 8.0;
-  uint m1i = round(m1);
-  uint u1i = round(u1);
-  uint m2i = round(m2);
-  uint u2i = round(u2);
+  uint m1i = round_fu(m1);
+  uint u1i = round_fu(u1);
+  uint m2i = round_fu(m2);
+  uint u2i = round_fu(u2);
   ValueType q1down = (ValueType) m1i / (m1i + u1i + pseudo); 
   ValueType q2down = (ValueType) (m2i + pseudo) / (m2i + pseudo + u2i); 
   ValueType pdown = log_binom(m1i, u1i, q1down) + log_binom(m2i, u2i, q2down);
@@ -902,10 +902,10 @@ pdown_pseudo_count(float m1, float u1, float m2, float u2) const
 GlobalStatistics::ValueType GlobalStatistics::
 pnochange_pseudo_count(float m1, float u1, float m2, float u2) const
 {
-  uint m1i = round(m1);
-  uint u1i = round(u1);
-  uint m2i = round(m2);
-  uint u2i = round(u2);
+  uint m1i = round_fu(m1);
+  uint u1i = round_fu(u1);
+  uint m2i = round_fu(m2);
+  uint u2i = round_fu(u2);
   ValueType q0 = (ValueType) (m1i + m2i) / (m1i + u1i + m2i + u2i);
   ValueType pnochange = log_binom(m1i, u1i, q0) + log_binom(m2i, u2i, q0);
 
diff --git a/ComMet/src/InputFormat.cc b/ComMet/src/InputFormat.cc
index a3a552c..4678672 100644
--- a/ComMet/src/InputFormat.cc
+++ b/ComMet/src/InputFormat.cc
@@ -54,7 +54,7 @@ parse_counts(vector<float>& m, vector<float>& u,
       ok = false;
       continue;
     }
-    if (round(m_v) == 0 && round(u_v) == 0) {
+    if (round_fu(m_v) == 0 && round_fu(u_v) == 0) {
       ok = false;
       continue;
     }
diff --git a/ComMet/src/Utility.cc b/ComMet/src/Utility.cc
index d123054..54883de 100644
--- a/ComMet/src/Utility.cc
+++ b/ComMet/src/Utility.cc
@@ -41,7 +41,7 @@ formatval(const char* format, double val)
 }
 
 uint 
-round(float x) 
+round_fu(float x) 
 {
   assert(x >= 0.0);
   return (uint) (x + 0.5);
diff --git a/ComMet/src/Utility.hh b/ComMet/src/Utility.hh
index d378735..299e7f4 100644
--- a/ComMet/src/Utility.hh
+++ b/ComMet/src/Utility.hh
@@ -27,7 +27,7 @@ std::string
 formatval(const char* format, double val);
 
 uint 
-round(float x);
+round_fu(float x);
 
 double 
 fast_gamma(double x);

