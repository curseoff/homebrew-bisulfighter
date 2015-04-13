class Bisulfighter < Formula
  homepage "http://epigenome.cbrc.jp/bisulfighter/"
  url "https://github.com/yutaka-saito/Bisulfighter/archive/v20150318.tar.gz"
  sha256 "d305a5fd8f7b022d2f57bf3b8ff311279716e6a3dc0956510dc2a1d4d3311d1d"

  depends_on "python"
  depends_on "boost"
  depends_on "last"

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
    sha256 "fa9ef533697d70d0ca4e2cd90847a1b3356a86e6bd61157a39960981e3029474" => :yosemite
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

