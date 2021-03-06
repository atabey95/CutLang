%option noyywrap
%option yylineno
%{
class Node;
#include "stdlib.h"
#include <string>
#include <map>
#include <list>
#include <vector>
#include <iostream>
#include "myParticle.h"
#include "b.hpp"
%}
integer [0-9]+
exp `[eE][+-]?{integer}'
real {integer}("."{integer})
varname [a-zA-Z]+{integer}
vardef {varname}" "?":"" "?.*"\n"
%%
"def"|"define" return DEF;//case sensitive in this case
"cmd"|"cut"|"select"|"command" return CMD;
"reject" return REJEC;
"obj"|"object" return OBJ;
"algo"|"region"|"algorithm" return ALGO;
"TRGe" return TRGE;
"TRGm" return TRGM;

[tT][aA][kK][eE]|[uU][sS][iI][nN][gG] return TAKE;
[hH][iI][sS][tT][oO] return HISTO;
[wW][eE][iI][gG][hH][tT] return WEIGHT;
[tT][aA][bB][lL][eE] return TABLE;
[Ss][Kk][Ii][Pp][Hh][Ii][Ss][Tt][Oo][Ss] return SKPH;
[Ss][Kk][Ii][Pp][Ee][Ff][Ff][Ss] return SKPE;
[Gg][Ee][Nn] return GEN;
[eE][lL][eE]|"Electron" return ELE;//particles
[mM][uU][oO]|"Muon" return MUO;
[tT][aA][uU] return TAU;
[pP][hH][oO]|"Photon" return PHO;
[jJ][eE][tT] return JET;
[fF][jJ][eE][tT]|"FatJet" return FJET;
[qQ][gG][jJ][eE][tT] return QGJET;
[bB][iI][nN] return BINS;
"NUMET" return NUMET;
"METLV" return METLV;
"LEP" return LEP;
"BJET" return BJET;

[uU][nN][iI][oO][nN] return UNION;
[aA][lL][iI][aA][sS] return ALIAS;
[bB][tT][aA][gG] return ISBTAG;
[cC][tT][aA][gG] return ISCTAG;
[tT][aA][uU][tT][aA][gG] return ISTAUTAG;
[pP][dD][gG][iI][dD] return PDGID;
[sS][tT][aA][tT][uU][sS] return STATUS;
[vV][tT] return VERT;
[vV][xX] return VERX;
[vV][yY] return VERY;
[vV][zZ] return VERZ;
"btagDeepB" return DEEPB;
"msoftdrop" return MSOFTD;
"tau1" return TAU1;
"tau2" return TAU2;
"tau3" return TAU3;
"fmegajets" return FMEGAJETS;
"fMR" return FMR;
"fMTR" return FMTR;
"fMTauTau" return FMTAUTAU;
"miniPFRelIsoAll" return RELISO;
"dxy"|[dD]"0" return DXY;
"dz" return DZ;
"dMVAnewDM2017v2" return TAUISO;
"softId" return SOFTID;

[pP][hT][iI] return PHI;//functions
[eE][tT][aA] return ETA;
[rR][aA][pP] return RAP;
[Aa][bB][sS][Ee][tT][aA] return ABSETA;
[pP][tT] return PT;
[pP][zZ] return PZ;
[dD][rR] return DR;
[dD][pP][hH][iI] return DPHI;
[dD][eE][tT][aA] return DETA;
[sS][iI][zZ][eE]|"Count"|"NumOf" return NUMOF;//no arg funcs
"nbf" return NBF;
"HT" return HT;
"METMWT" return METMWT;
"MWT" return MWT;
"MET" return MET;
"ALL" return ALL;
"LEPsf" return LEPSF;
"bTagSF" return BTAGSF;
"=="|"EQ" return EQ;//comparison operators
"<>"|"NE" return NE;
"!=" return MAXIMIZE;
"~=" return MINIMIZE;
"<="|"LE" return LE;
">="|"GE" return GE;
"<"|"LT" return LT;
">"|"GT" return GT;
"[]" return IRG;
"][" return ERG;
"AND"|"&&"|"and" return AND;//logical ops
"OR"|"||"|"or" return OR;
"NOT" return NOT;
"#".*"\n" ;
[ \t\n] ;
[sS][uU][mM] return SUM;
[sS][aA][vV][eE] return SAVE;
[Aa][Ss][Cc][Ee][Nn][Dd] return ASCEND;
[Dd][Ee][Ss][Cc][Ee][Nn][Dd] return DESCEND;
[tT][aA][nN] return TAN;
[sS][iI][nN] return SIN;
[cC][oO][sS] return COS;
[sS][iI][nN][hH] return SINH;
[cC][oO][sS][hH] return COSH;
[tT][aA][nN][hH] return TANH;
[eE][xX][pP] return EXP;
[lL][oO][gG] return LOG;
[Hh][Ss][Tt][Ee][Pp] return HSTEP;
[aA][bB][sS] return ABS;
[sS][qQ][rR][tT] return SQRT;
[sS][oO][rR][tT] return SORT;
[cC][oO][mM][bB] return COMB;
[pP][eE][rR][mM] return PERM;
[mM][iI][nN] return MIN;
[mM][aA][xX] return MAX;
[-]?{integer} sscanf(yytext, "%d",&yylval.integer);return INT;
[-]?{real} sscanf(yytext, "%lf",&yylval.real);return NB ;
[-+*/()^:\[\]{}_mqPE,?=] return *yytext;
[a-zA-Z]+{integer}?[a-zA-Z]+{integer}* yylval.s=strdup(yytext);return ID;
"\"".*"\"" yylval.s=strdup(yytext);return HID;
%%
