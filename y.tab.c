/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.4"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 1 "yacc.y" /* yacc.c:339  */

	#include <stdlib.h>
	#include <string.h>
	#include <stdio.h>
	FILE *yyin;
	int yyerror();
	int yylex();
	char* type;
	int err = 0;
	FILE* fp;
	
	typedef struct NODE
	{
		char name[20];
		int line;
		int scopeid;
		int scopedepth;
		struct NODE* next;
	}NODE;

	typedef struct symbol_table
	{
		NODE* head;
		int entries;
	}TABLE;
	
	TABLE* s;
	extern int scopeid;
	extern int scopedepth;

	void print();
	int exists(char* name, int pscopeid);
	void insert(char* name, int line, int pscopeid, int pscopedepth) ;
	extern int yylineno;

#line 102 "y.tab.c" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif


/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    RETURN = 258,
    SEMICOLON = 259,
    NUM = 260,
    VAR = 261,
    TRUE = 262,
    FALSE = 263,
    IF = 264,
    FOR = 265,
    IN = 266,
    OF = 267,
    ELSE = 268,
    STRING = 269,
    IDENTIFIER = 270,
    UNARYPLUS = 271,
    UNARYMINUS = 272
  };
#endif
/* Tokens.  */
#define RETURN 258
#define SEMICOLON 259
#define NUM 260
#define VAR 261
#define TRUE 262
#define FALSE 263
#define IF 264
#define FOR 265
#define IN 266
#define OF 267
#define ELSE 268
#define STRING 269
#define IDENTIFIER 270
#define UNARYPLUS 271
#define UNARYMINUS 272

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);



/* Copy the second part of user declarations.  */

#line 184 "y.tab.c" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  28
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   143

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  36
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  27
/* YYNRULES -- Number of rules.  */
#define YYNRULES  67
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  136

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   272

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    23,     2,     2,     2,     2,    25,     2,
      18,    19,    31,    29,    22,    30,     2,    32,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
      26,    28,    27,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    34,     2,    35,    33,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    20,    24,    21,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint8 yyrline[] =
{
       0,    41,    41,    42,    43,    44,    45,    46,    47,    48,
      49,    49,    51,    53,    54,    56,    57,    59,    60,    62,
      63,    65,    66,    68,    69,    70,    71,    73,    74,    76,
      76,    76,    76,    76,    76,    78,    79,    80,    82,    83,
      84,    86,    87,    89,    90,    91,    93,    94,    95,    97,
      98,    99,   101,   101,   103,   105,   105,   107,   109,   111,
     111,   111,   113,   115,   115,   117,   117,   117
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "RETURN", "SEMICOLON", "NUM", "VAR",
  "TRUE", "FALSE", "IF", "FOR", "IN", "OF", "ELSE", "STRING", "IDENTIFIER",
  "UNARYPLUS", "UNARYMINUS", "'('", "')'", "'{'", "'}'", "','", "'!'",
  "'|'", "'&'", "'<'", "'>'", "'='", "'+'", "'-'", "'*'", "'/'", "'^'",
  "'['", "']'", "$accept", "Program", "Statement", "Declaration",
  "Variables", "Variable", "Condition", "OrExpression", "AndExpression",
  "ConditionalBase", "RelationalExpression", "RelationalOperator",
  "Expression", "MultDiv", "ExponentialExpression", "UnaryPostExpression",
  "UnaryPreExpression", "ExpressionBase", "Initialisation",
  "AssignmentExpression", "AssignmentRHS", "InExpression", "OfExpression",
  "Iterable", "Array", "Elements", "Element", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,    40,    41,
     123,   125,    44,    33,   124,    38,    60,    62,    61,    43,
      45,    42,    47,    94,    91,    93
};
# endif

#define YYPACT_NINF -45

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-45)))

#define YYTABLE_NINF -1

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int8 yypact[] =
{
      64,    35,   -10,    -7,    13,     6,    59,   -45,    65,    74,
     -45,   -45,    40,    40,    35,     3,    -4,   -45,    30,    68,
     -45,     6,    70,   -45,   -45,     7,    79,     1,   -45,    64,
      64,   -45,   -45,    46,    64,    35,    35,    35,    35,    35,
     -45,   -45,   -10,   -45,   -45,     7,    31,    61,    86,    87,
     -45,    63,    71,     9,   107,   -45,    94,    97,    57,    63,
     -45,   -45,   -45,   -45,   -45,   -45,    -4,    -4,   -45,   -45,
     -45,   -45,    98,    46,    86,    95,    99,    93,    91,    92,
     100,   101,    35,    -5,    -5,     7,   102,   104,   -45,   -45,
     -45,    21,   -45,   -45,    64,    31,    31,   -45,   -45,   -45,
     -45,    71,   -45,   -45,   -45,   -45,   -45,   117,    64,    64,
      57,   -45,   105,    87,   -45,    35,   106,   109,   -45,    51,
      58,    64,    64,   111,   -45,   112,   -45,   -45,    64,    64,
     113,   114,    64,    64,   -45,   -45
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
      11,     0,     0,     0,     0,     0,     0,     2,     0,     0,
      51,    50,     0,     0,     0,     0,    37,    40,    42,    45,
      48,    15,    12,    14,    16,     0,    53,     0,     1,    11,
      11,    46,    47,     0,    11,     0,     0,     0,     0,     0,
      43,    44,     0,    25,    26,     0,     0,     0,    18,    20,
      22,    24,    28,     0,     0,    52,     0,     0,     0,    55,
      54,    56,     9,    10,    49,     8,    35,    36,    38,    39,
      41,    13,     0,    28,    17,     0,     0,     0,     0,    29,
      30,     0,     0,     0,     0,     0,     0,     0,    66,    67,
      65,     0,    64,    23,    11,     0,     0,    34,    31,    32,
      33,    27,    60,    61,    57,    59,    58,     0,    11,    11,
       0,    62,     0,    19,    21,     0,     0,     0,    63,    11,
       0,    11,    11,     0,     4,     0,     6,     7,    11,    11,
       0,     0,    11,    11,     3,     5
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -45,   -45,   -26,   -45,   -45,    83,   -44,    90,    38,    41,
     115,   -45,    -1,    69,    60,   -45,   -45,    96,   -45,     0,
     -45,   -45,   -45,    54,   116,   -45,    29
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     6,     7,     8,    22,    23,    47,    48,    49,    50,
      51,    82,    52,    16,    17,    18,    19,    20,    54,     9,
      60,    56,    57,   104,   105,    91,    92
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
      15,    72,    24,    62,    63,    21,    10,    34,    65,   102,
     103,    25,    10,    33,    43,    44,    11,    12,    13,    14,
      83,    84,    11,    12,    13,    45,    55,    37,    38,    58,
      46,    26,    35,    36,    27,    58,    10,    27,    43,    44,
      10,   107,    24,   110,    73,    10,    11,    12,    13,    45,
      11,    12,    13,    14,     1,    11,   111,     2,    14,    28,
       3,     4,    88,    39,   123,    64,     5,     1,   112,    29,
       2,    89,    90,     3,     4,    35,    36,   125,    30,     5,
      75,   101,   116,   117,    40,    41,    78,    35,    36,    79,
      80,    81,    42,   124,    53,   126,   127,    68,    69,    70,
      35,    36,   130,   131,    66,    67,   134,   135,    31,    32,
      76,    85,    77,    86,   120,    94,    87,    93,    96,    97,
      98,   115,   108,    95,   109,    71,   119,   121,    99,   100,
     122,   128,   129,   113,   132,   133,    74,   114,   106,   118,
       0,     0,    59,    61
};

static const yytype_int16 yycheck[] =
{
       1,    45,     2,    29,    30,    15,     5,     4,    34,    14,
      15,    18,     5,    14,     7,     8,    15,    16,    17,    18,
      11,    12,    15,    16,    17,    18,    26,    31,    32,    34,
      23,    18,    29,    30,    28,    34,     5,    28,     7,     8,
       5,    85,    42,    22,    45,     5,    15,    16,    17,    18,
      15,    16,    17,    18,     3,    15,    35,     6,    18,     0,
       9,    10,     5,    33,    13,    19,    15,     3,    94,     4,
       6,    14,    15,     9,    10,    29,    30,    19,     4,    15,
      19,    82,   108,   109,    16,    17,    23,    29,    30,    26,
      27,    28,    22,   119,    15,   121,   122,    37,    38,    39,
      29,    30,   128,   129,    35,    36,   132,   133,    12,    13,
      24,     4,    25,    19,   115,    20,    19,    19,    25,    28,
      28,     4,    20,    24,    20,    42,    21,    21,    28,    28,
      21,    20,    20,    95,    21,    21,    46,    96,    84,   110,
      -1,    -1,    27,    27
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,     6,     9,    10,    15,    37,    38,    39,    55,
       5,    15,    16,    17,    18,    48,    49,    50,    51,    52,
      53,    15,    40,    41,    55,    18,    18,    28,     0,     4,
       4,    53,    53,    48,     4,    29,    30,    31,    32,    33,
      16,    17,    22,     7,     8,    18,    23,    42,    43,    44,
      45,    46,    48,    15,    54,    55,    57,    58,    34,    46,
      56,    60,    38,    38,    19,    38,    49,    49,    50,    50,
      50,    41,    42,    48,    43,    19,    24,    25,    23,    26,
      27,    28,    47,    11,    12,     4,    19,    19,     5,    14,
      15,    61,    62,    19,    20,    24,    25,    28,    28,    28,
      28,    48,    14,    15,    59,    60,    59,    42,    20,    20,
      22,    35,    38,    44,    45,     4,    38,    38,    62,    21,
      48,    21,    21,    13,    38,    19,    38,    38,    20,    20,
      38,    38,    21,    21,    38,    38
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    36,    37,    38,    38,    38,    38,    38,    38,    38,
      38,    38,    39,    40,    40,    41,    41,    42,    42,    43,
      43,    44,    44,    45,    45,    45,    45,    46,    46,    47,
      47,    47,    47,    47,    47,    48,    48,    48,    49,    49,
      49,    50,    50,    51,    51,    51,    52,    52,    52,    53,
      53,    53,    54,    54,    55,    56,    56,    57,    58,    59,
      59,    59,    60,    61,    61,    62,    62,    62
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,    12,     8,    12,     8,     8,     4,     3,
       3,     0,     2,     3,     1,     1,     1,     2,     1,     4,
       1,     4,     1,     3,     1,     1,     1,     3,     1,     1,
       1,     2,     2,     2,     2,     3,     3,     1,     3,     3,
       1,     3,     1,     2,     2,     1,     2,     2,     1,     3,
       1,     1,     1,     0,     3,     1,     1,     3,     3,     1,
       1,     1,     3,     3,     1,     1,     1,     1
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yystacksize);

        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 41 "yacc.y" /* yacc.c:1646  */
    {printf("Program -> Statement\n"); YYACCEPT;}
#line 1352 "y.tab.c" /* yacc.c:1646  */
    break;

  case 3:
#line 42 "yacc.y" /* yacc.c:1646  */
    {printf("Statement -> if else\n");}
#line 1358 "y.tab.c" /* yacc.c:1646  */
    break;

  case 4:
#line 43 "yacc.y" /* yacc.c:1646  */
    {printf("Statement -> if\n");}
#line 1364 "y.tab.c" /* yacc.c:1646  */
    break;

  case 5:
#line 44 "yacc.y" /* yacc.c:1646  */
    {printf("Statement -> for\n");}
#line 1370 "y.tab.c" /* yacc.c:1646  */
    break;

  case 6:
#line 45 "yacc.y" /* yacc.c:1646  */
    {printf("Statement -> for in\n");}
#line 1376 "y.tab.c" /* yacc.c:1646  */
    break;

  case 7:
#line 46 "yacc.y" /* yacc.c:1646  */
    {printf("Statement -> for of\n");}
#line 1382 "y.tab.c" /* yacc.c:1646  */
    break;

  case 8:
#line 47 "yacc.y" /* yacc.c:1646  */
    {printf("Statement -> return\n");}
#line 1388 "y.tab.c" /* yacc.c:1646  */
    break;

  case 9:
#line 48 "yacc.y" /* yacc.c:1646  */
    {printf("Statement -> Declaration\n");}
#line 1394 "y.tab.c" /* yacc.c:1646  */
    break;

  case 10:
#line 49 "yacc.y" /* yacc.c:1646  */
    {printf("Statement -> Assignment\n");}
#line 1400 "y.tab.c" /* yacc.c:1646  */
    break;

  case 12:
#line 51 "yacc.y" /* yacc.c:1646  */
    {printf("Declaration -> var variables\n");}
#line 1406 "y.tab.c" /* yacc.c:1646  */
    break;

  case 13:
#line 53 "yacc.y" /* yacc.c:1646  */
    {printf("Variables -> Comma\n");}
#line 1412 "y.tab.c" /* yacc.c:1646  */
    break;

  case 14:
#line 54 "yacc.y" /* yacc.c:1646  */
    {printf("Variables -> Variable\n");}
#line 1418 "y.tab.c" /* yacc.c:1646  */
    break;

  case 15:
#line 56 "yacc.y" /* yacc.c:1646  */
    {printf("Variable -> Identifier\n");  insert((yyvsp[0]), yylineno, scopeid, scopedepth);}
#line 1424 "y.tab.c" /* yacc.c:1646  */
    break;

  case 16:
#line 57 "yacc.y" /* yacc.c:1646  */
    {printf("Variable -> AssignmentExp\n");}
#line 1430 "y.tab.c" /* yacc.c:1646  */
    break;

  case 17:
#line 59 "yacc.y" /* yacc.c:1646  */
    {printf("Condition -> !OrExp\n");}
#line 1436 "y.tab.c" /* yacc.c:1646  */
    break;

  case 18:
#line 60 "yacc.y" /* yacc.c:1646  */
    {printf("Condition -> OrExp\n");}
#line 1442 "y.tab.c" /* yacc.c:1646  */
    break;

  case 19:
#line 62 "yacc.y" /* yacc.c:1646  */
    {printf("OrExp -> Or || And\n");}
#line 1448 "y.tab.c" /* yacc.c:1646  */
    break;

  case 20:
#line 63 "yacc.y" /* yacc.c:1646  */
    {printf("OrExp -> AndExp\n");}
#line 1454 "y.tab.c" /* yacc.c:1646  */
    break;

  case 21:
#line 65 "yacc.y" /* yacc.c:1646  */
    {printf("AndExp -> AndExp && ConditionalBase\n");}
#line 1460 "y.tab.c" /* yacc.c:1646  */
    break;

  case 22:
#line 66 "yacc.y" /* yacc.c:1646  */
    {printf("AndExp -> ConditionalBase\n");}
#line 1466 "y.tab.c" /* yacc.c:1646  */
    break;

  case 23:
#line 68 "yacc.y" /* yacc.c:1646  */
    {printf("ConditionalBase -> ( Condition) )\n");}
#line 1472 "y.tab.c" /* yacc.c:1646  */
    break;

  case 24:
#line 69 "yacc.y" /* yacc.c:1646  */
    {printf("ConditionalBase -> RelationalExpression\n");}
#line 1478 "y.tab.c" /* yacc.c:1646  */
    break;

  case 25:
#line 70 "yacc.y" /* yacc.c:1646  */
    {printf("ConditionalBase -> TRUE\n");}
#line 1484 "y.tab.c" /* yacc.c:1646  */
    break;

  case 26:
#line 71 "yacc.y" /* yacc.c:1646  */
    {printf("ConditionalBase -> FALSE\n");}
#line 1490 "y.tab.c" /* yacc.c:1646  */
    break;

  case 27:
#line 73 "yacc.y" /* yacc.c:1646  */
    {printf("RelExp -> RelExp RelOp Exp\n");}
#line 1496 "y.tab.c" /* yacc.c:1646  */
    break;

  case 28:
#line 74 "yacc.y" /* yacc.c:1646  */
    {printf("RelationalExpression -> Expression\n");}
#line 1502 "y.tab.c" /* yacc.c:1646  */
    break;

  case 35:
#line 78 "yacc.y" /* yacc.c:1646  */
    {printf("Exp -> Exp + MultDiv\n");}
#line 1508 "y.tab.c" /* yacc.c:1646  */
    break;

  case 36:
#line 79 "yacc.y" /* yacc.c:1646  */
    {printf("Exp -> Exp - MultDiv\n");}
#line 1514 "y.tab.c" /* yacc.c:1646  */
    break;

  case 37:
#line 80 "yacc.y" /* yacc.c:1646  */
    {printf("Exp -> MultDiv\n");}
#line 1520 "y.tab.c" /* yacc.c:1646  */
    break;

  case 38:
#line 82 "yacc.y" /* yacc.c:1646  */
    {printf("MultDiv -> Exponential\n");}
#line 1526 "y.tab.c" /* yacc.c:1646  */
    break;

  case 39:
#line 83 "yacc.y" /* yacc.c:1646  */
    {printf("MultDiv -> MultDiv / Exponential\n");}
#line 1532 "y.tab.c" /* yacc.c:1646  */
    break;

  case 40:
#line 84 "yacc.y" /* yacc.c:1646  */
    {printf("MultDiv -> Exponential\n");}
#line 1538 "y.tab.c" /* yacc.c:1646  */
    break;

  case 41:
#line 86 "yacc.y" /* yacc.c:1646  */
    {printf("Exponential -> UnaryPost ^ Exponential\n");}
#line 1544 "y.tab.c" /* yacc.c:1646  */
    break;

  case 42:
#line 87 "yacc.y" /* yacc.c:1646  */
    {printf("Exponential -> UnaryPost\n");}
#line 1550 "y.tab.c" /* yacc.c:1646  */
    break;

  case 43:
#line 89 "yacc.y" /* yacc.c:1646  */
    {printf("UnaryPost -> UnaryPre ++\n");}
#line 1556 "y.tab.c" /* yacc.c:1646  */
    break;

  case 44:
#line 90 "yacc.y" /* yacc.c:1646  */
    {printf("UnaryPost -> UnaryPre --\n");}
#line 1562 "y.tab.c" /* yacc.c:1646  */
    break;

  case 45:
#line 91 "yacc.y" /* yacc.c:1646  */
    {printf("UnaryPost -> Unary\n");}
#line 1568 "y.tab.c" /* yacc.c:1646  */
    break;

  case 46:
#line 93 "yacc.y" /* yacc.c:1646  */
    {printf("UnaryPre -> ++ ExpBase\n");}
#line 1574 "y.tab.c" /* yacc.c:1646  */
    break;

  case 47:
#line 94 "yacc.y" /* yacc.c:1646  */
    {printf("UnaryPre -> -- ExpBase\n");}
#line 1580 "y.tab.c" /* yacc.c:1646  */
    break;

  case 48:
#line 95 "yacc.y" /* yacc.c:1646  */
    {printf("UnaryPre -> ExpBase\n");}
#line 1586 "y.tab.c" /* yacc.c:1646  */
    break;

  case 49:
#line 97 "yacc.y" /* yacc.c:1646  */
    {printf("ExpBase -> ( Expression )\n");}
#line 1592 "y.tab.c" /* yacc.c:1646  */
    break;

  case 50:
#line 98 "yacc.y" /* yacc.c:1646  */
    {printf("ExpBase -> IDENTIFIER\n");}
#line 1598 "y.tab.c" /* yacc.c:1646  */
    break;

  case 51:
#line 99 "yacc.y" /* yacc.c:1646  */
    {printf("ExpBase -> NUM\n");}
#line 1604 "y.tab.c" /* yacc.c:1646  */
    break;

  case 52:
#line 101 "yacc.y" /* yacc.c:1646  */
    {printf("Initialisation -> AssignmentExpression\n");}
#line 1610 "y.tab.c" /* yacc.c:1646  */
    break;

  case 54:
#line 103 "yacc.y" /* yacc.c:1646  */
    {printf("AssignmentExp -> IDENTIFIER '=' AssignmentRHS\n");}
#line 1616 "y.tab.c" /* yacc.c:1646  */
    break;

  case 55:
#line 105 "yacc.y" /* yacc.c:1646  */
    {printf("AssignmentRHS -> RelExp\n");}
#line 1622 "y.tab.c" /* yacc.c:1646  */
    break;

  case 56:
#line 105 "yacc.y" /* yacc.c:1646  */
    {printf("AssignmentExp -> Array\n");}
#line 1628 "y.tab.c" /* yacc.c:1646  */
    break;


#line 1632 "y.tab.c" /* yacc.c:1646  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 119 "yacc.y" /* yacc.c:1906  */




int yyerror()
{
	printf("\nInvalid!\n");
	return 0;
}

int main()
{
	printf("Enter\n");
	s = (TABLE *)malloc(sizeof(TABLE));
	s->head=NULL;
	s->entries=0;
	fp = fopen("symbol_table.txt","w");
	if(!yyparse())
	{
		printf("\nValid!\n");
		print();
	}
	return 0;
}


void insert(char* name, int line, int pscopeid, int pscopedepth)
{
	printf("Insert function\n");
	if(exists(name, pscopeid))
	{
		printf("Warning: Variable %s of scope ID %d already declared\n",name, pscopeid);
		//err++;
		return;
	}
	printf("Passed arg : %s %d %d %d\n", name, line, pscopeid, pscopedepth);
    NODE* test = (NODE*) malloc(sizeof(NODE));
    strcpy(test->name,name);
	test->next = NULL;
	test->scopeid = pscopeid;
	test->scopedepth = pscopedepth;
	test->line = line;
	printf("Stored arg : %s %d %d %d\n", test->name, test->line, test->scopeid, test->scopedepth);

	NODE* h = s->head;

	if(h==NULL)
	{
		s->head = test;
		s->entries += 1;
		return;
	}
	while(h->next != NULL)
	{
		h = h->next;
	}
	h->next = test;
	s->entries += 1;
}

int exists(char* name, int pscopeid)
{
	printf("Exists function\n");
	NODE* temp = s->head;
	printf("%p\n", s->head);
	if(s->head == NULL){
		printf("Table empty");
		return 0;
	}
	while(temp != NULL)
	{
		if(strcmp(temp->name,name) == 0 && temp->scopeid == pscopeid){
			printf("Found");
			return 1;
		}
		temp = temp->next;
	}
	return 0;
}

void print()
{
	NODE* h = s->head;
	fp = fopen("symbol_table.txt","w");
	fprintf(fp,"Symbol table:\nName\tLineno\tScope Depth\n");
	for(int i=0;i<s->entries; i++ )
	{
		fprintf(fp,"%s\t%d\t%d\n", h->name, h->line, h->scopedepth);
		h=h->next;
	}
}
