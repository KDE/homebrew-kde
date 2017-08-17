require "formula"

class Kf5Kjs < Formula
  url "http://download.kde.org/stable/frameworks/5.37/portingAids/kjs-5.37.0.tar.xz"
  sha256 "2be1dd4e8a6b0914d3f1c7bc4ee0d2666b8166430adb576e17d7441225f2d010"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kjs.git"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "qt"
  depends_on "pcre"

  #  def patches
  #    DATA
  #  end

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end

__END__
diff --git a/src/kjs/grammar.cpp b/src/kjs/grammar.cpp
index 837cfa0..078dbc2 100644
--- a/src/kjs/grammar.cpp
+++ b/src/kjs/grammar.cpp
@@ -2771,7 +2771,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 258 "grammar.y"
         {
-            if (!makeGetterOrSetterPropertyNode((yyval.pnode), *(yyvsp[(1) - (6)].ident), *(yyvsp[(2) - (6)].ident), nullptr, (yyvsp[(6) - (6)].body))) {
+            if (!makeGetterOrSetterPropertyNode((yyval.pnode), *(yyvsp[(1) - (6)].ident), *(yyvsp[(2) - (6)].ident), 0, (yyvsp[(6) - (6)].body))) {
                 YYABORT;
             }
         }
@@ -3863,7 +3863,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 683 "grammar.y"
         {
-            (yyval.stat) = new BlockNode(nullptr);
+            (yyval.stat) = new BlockNode(0);
             DBG((yyval.stat), (yylsp[(2) - (2)]), (yylsp[(2) - (2)]));
         }
         break;
@@ -3932,7 +3932,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 705 "grammar.y"
         {
-            (yyval.decl) = new VarDeclNode(*(yyvsp[(1) - (1)].ident), nullptr, VarDeclNode::Variable);
+            (yyval.decl) = new VarDeclNode(*(yyvsp[(1) - (1)].ident), 0, VarDeclNode::Variable);
         }
         break;
 
@@ -3948,7 +3948,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 710 "grammar.y"
         {
-            (yyval.decl) = new VarDeclNode(*(yyvsp[(1) - (1)].ident), nullptr, VarDeclNode::Variable);
+            (yyval.decl) = new VarDeclNode(*(yyvsp[(1) - (1)].ident), 0, VarDeclNode::Variable);
         }
         break;
 
@@ -3999,7 +3999,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 727 "grammar.y"
         {
-            (yyval.decl) = new VarDeclNode(*(yyvsp[(1) - (1)].ident), nullptr, VarDeclNode::Constant);
+            (yyval.decl) = new VarDeclNode(*(yyvsp[(1) - (1)].ident), 0, VarDeclNode::Constant);
         }
         break;
 
@@ -4058,7 +4058,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 750 "grammar.y"
         {
-            (yyval.stat) = makeIfNode((yyvsp[(3) - (5)].node), (yyvsp[(5) - (5)].stat), nullptr);
+            (yyval.stat) = makeIfNode((yyvsp[(3) - (5)].node), (yyvsp[(5) - (5)].stat), 0);
             DBG((yyval.stat), (yylsp[(1) - (5)]), (yylsp[(4) - (5)]));
         }
         break;
@@ -4135,7 +4135,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 772 "grammar.y"
         {
-            (yyval.stat) = new ForInNode(*(yyvsp[(4) - (8)].ident), nullptr, (yyvsp[(6) - (8)].node), (yyvsp[(8) - (8)].stat));
+            (yyval.stat) = new ForInNode(*(yyvsp[(4) - (8)].ident), 0, (yyvsp[(6) - (8)].node), (yyvsp[(8) - (8)].stat));
             DBG((yyval.stat), (yylsp[(1) - (8)]), (yylsp[(7) - (8)]));
         }
         break;
@@ -4153,7 +4153,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 778 "grammar.y"
         {
-            (yyval.node) = nullptr;
+            (yyval.node) = 0;
         }
         break;
 
@@ -4161,7 +4161,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 783 "grammar.y"
         {
-            (yyval.node) = nullptr;
+            (yyval.node) = 0;
         }
         break;
 
@@ -4245,7 +4245,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 802 "grammar.y"
         {
-            (yyval.stat) = new ReturnNode(nullptr);
+            (yyval.stat) = new ReturnNode(0);
             DBG((yyval.stat), (yylsp[(1) - (2)]), (yylsp[(2) - (2)]));
         }
         break;
@@ -4254,7 +4254,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 803 "grammar.y"
         {
-            (yyval.stat) = new ReturnNode(nullptr);
+            (yyval.stat) = new ReturnNode(0);
             DBG((yyval.stat), (yylsp[(1) - (2)]), (yylsp[(1) - (2)]));
             AUTO_SEMICOLON;
         }
@@ -4301,7 +4301,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 817 "grammar.y"
         {
-            (yyval.cblk) = new CaseBlockNode((yyvsp[(2) - (3)].clist), nullptr, nullptr);
+            (yyval.cblk) = new CaseBlockNode((yyvsp[(2) - (3)].clist), 0, 0);
         }
         break;
 
@@ -4317,7 +4317,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 823 "grammar.y"
         {
-            (yyval.clist) = nullptr;
+            (yyval.clist) = 0;
         }
         break;
 
@@ -4357,7 +4357,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 838 "grammar.y"
         {
-            (yyval.ccl) = new CaseClauseNode(nullptr);
+            (yyval.ccl) = new CaseClauseNode(0);
         }
         break;
 
@@ -4365,7 +4365,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 839 "grammar.y"
         {
-            (yyval.ccl) = new CaseClauseNode(nullptr, (yyvsp[(3) - (3)].srcs));
+            (yyval.ccl) = new CaseClauseNode(0, (yyvsp[(3) - (3)].srcs));
         }
         break;
 
@@ -4400,7 +4400,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 852 "grammar.y"
         {
-            (yyval.stat) = new TryNode((yyvsp[(2) - (4)].stat), CommonIdentifiers::shared()->nullIdentifier, nullptr, (yyvsp[(4) - (4)].stat));
+            (yyval.stat) = new TryNode((yyvsp[(2) - (4)].stat), CommonIdentifiers::shared()->nullIdentifier, 0, (yyvsp[(4) - (4)].stat));
             DBG((yyval.stat), (yylsp[(1) - (4)]), (yylsp[(2) - (4)]));
         }
         break;
@@ -4409,7 +4409,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 853 "grammar.y"
         {
-            (yyval.stat) = new TryNode((yyvsp[(2) - (7)].stat), *(yyvsp[(5) - (7)].ident), (yyvsp[(7) - (7)].stat), nullptr);
+            (yyval.stat) = new TryNode((yyvsp[(2) - (7)].stat), *(yyvsp[(5) - (7)].ident), (yyvsp[(7) - (7)].stat), 0);
             DBG((yyval.stat), (yylsp[(1) - (7)]), (yylsp[(2) - (7)]));
         }
         break;
@@ -4462,7 +4462,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 869 "grammar.y"
         {
-            (yyval.stat) = makeImportNode((yyvsp[(2) - (5)].pkgn), true, nullptr);
+            (yyval.stat) = makeImportNode((yyvsp[(2) - (5)].pkgn), true, 0);
             DBG((yyval.stat), (yylsp[(1) - (5)]), (yylsp[(5) - (5)]));
         }
         break;
@@ -4471,7 +4471,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 871 "grammar.y"
         {
-            (yyval.stat) = makeImportNode((yyvsp[(2) - (5)].pkgn), true, nullptr);
+            (yyval.stat) = makeImportNode((yyvsp[(2) - (5)].pkgn), true, 0);
             DBG((yyval.stat), (yylsp[(1) - (5)]), (yylsp[(5) - (5)])); AUTO_SEMICOLON;
         }
         break;
@@ -4480,7 +4480,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 873 "grammar.y"
         {
-            (yyval.stat) = makeImportNode((yyvsp[(2) - (3)].pkgn), false, nullptr);
+            (yyval.stat) = makeImportNode((yyvsp[(2) - (3)].pkgn), false, 0);
             DBG((yyval.stat), (yylsp[(1) - (3)]), (yylsp[(3) - (3)]));
         }
         break;
@@ -4489,7 +4489,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 875 "grammar.y"
         {
-            (yyval.stat) = makeImportNode((yyvsp[(2) - (3)].pkgn), false, nullptr);
+            (yyval.stat) = makeImportNode((yyvsp[(2) - (3)].pkgn), false, 0);
             DBG((yyval.stat), (yylsp[(1) - (3)]), (yylsp[(3) - (3)])); AUTO_SEMICOLON;
         }
         break;
@@ -4628,7 +4628,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 908 "grammar.y"
         {
-            (yyval.body) = new FunctionBodyNode(nullptr);
+            (yyval.body) = new FunctionBodyNode(0);
             DBG((yyval.body), (yylsp[(1) - (2)]), (yylsp[(2) - (2)]));
         }
         break;
@@ -4646,7 +4646,7 @@ yyreduce:
         /* Line 1792 of yacc.c  */
 #line 913 "grammar.y"
         {
-            parser().didFinishParsing(new ProgramNode(nullptr));
+            parser().didFinishParsing(new ProgramNode(0));
         }
         break;
 
