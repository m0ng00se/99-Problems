%% ================================
%%      99 Questions in Erlang
%% -------------------------------- 
%% 
%% Reference for the Lisp questions: http://bit.ly/1id79HU
%%
%% @author Paul J. Sholtz
%% @copyright 2013-2015 sholtz9421.com
%% @doc Implementation of the 99 (Functional) Questions in Erlang.
%% @end
%% =================================
-module(p99).
-author('psholtz [at] gmail (dot) com').

%%
%% Remaining to do in Binary Trees: P64B, P65, P66, P67, P68C.
%% Remaining to do in Multiway Trees: P70, P72, P73.
%%

%% ========================= 
%% List Manipulation Exports
%% ========================= 
-export([my_last/1,            %% Problem 01
	 my_but_last/1,        %% Problem 02
	 element_at/2,         %% Problem 03
	 length/1,             %% Problem 04
	 reverse/1,            %% Problem 05
	 reverse_no_tail/1,
	 palindrome/1,         %% Problem 06
 	 my_flatten/1,         %% Problem 07
	 compress/1,           %% Problem 08
	 pack/1,               %% Problem 09
	 encode/1,             %% Problem 10
	 encode_modified/1,    %% Problem 11
	 encode_modified1/1,
	 decode_modified/1,    %% Problem 12
	 encode_direct/1,      %% Problem 13
	 dupli/1,              %% Problem 14
	 repli/2,              %% Problem 15 
	 drop/2,               %% Problem 16
	 split/2,              %% Problem 17
	 slice/3,              %% Problem 18
	 rotate/2,             %% Problem 19
	 remove_at/2,          %% Problem 20
	 insert_at/3,          %% Problem 21
	 range/2,              %% Problem 22
	 md_select/2,          %% Problem 23
	 lotto_select/2,       %% Problem 24
	 md_permu/1,           %% Problem 25
	 combinations/2,       %% Problem 26
	 group3/1,             %% Problem 27 
	 group/2,  
	 lsort/1,              %% Problem 28
	 lfsort/1
]).

%% ================== 
%% Arithmetic Exports
%% ================== 
-export([is_prime/1,              %% Problem 31
         is_prime1/1,
	 gcd/2,                   %% Problem 32
	 coprime/2,               %% Problem 33
	 totient_phi/1,           %% Problem 34
	 prime_factors/1,         %% Problem 35
	 prime_factors_mult/1,    %% Problem 36
	 totient_phi_improved/1,  %% Problem 37
	 totient_phi_compare/1,   %% Problem 38
	 prime_number_list/2,     %% Problem 39
	 goldbach/1,              %% Problem 40
	 goldbach_list/2,         %% Problem 41
	 goldbach_list/3         
]).

%% ======================
%% Logic and Code Exports
%% ======================
-export([b_and/2,                %% Problem 46
	 b_or/2,
	 n_and/2,
	 n_or/2,
	 x_or/2,
	 impl/2,
	 equ/2,
	 table/1,
	 table1/3,               %% Problem 47
	 b_not/1,
	 table2/2,               %% Problem 48
	 gray/1,                 %% Problem 49
	 gray_no_tail/1,
	 gray_imp/1,
	 huffman/1,              %% Problem 50
	 decode/2,               %% Problem 50 (unit test)
	 encode/2                %% Problem 50 (unit test)
]).

%% =================== 
%% Binary Tree Exports
%% =================== 
-export([is_tree/1,                  %% Problem 54A
	 make_binary_tree/0,         %% Problem 54A (unit test)
	 make_binary_tree/1,         %% Problem 54A (unit test)
	 make_binary_tree/3,         %% Problem 54A (unit test)
	 make_sample_tree/1,         %% Problem 54A (unit test)
	 make_sample_tree_fake/1,    %% Problem 54A (unit test)
	 cbal_tree/1,                %% Problem 55
	 symmetric/1,                %% Problem 56
	 construct/1,                %% Problem 57
	 sym_cbal_trees_print/1,     %% Problem 58
	 hbal_tree/1,                %% Problem 59
	 hbal_tree_nodes/1,          %% Problem 60
	 floor/1,                    %% Problem 60 (unit test)
	 count_leaves/1,             %% Problem 61
	 leaves/1,                   %% Problem 61A
	 internals/1,                %% Problem 62
	 at_level/2,                 %% Problem 62B
	 complete_binary_tree/1,     %% Problem 63
	 is_complete_binary_tree/1,  %% Problem 63 (unit test)
	 layout_binary_tree/1,       %% Problem 64
	 print_binary_tree/1,        %% Problem 64 (bonus)
	 binary_tree_to_string/1,    %% Problem 67
	 string_to_binary_tree/1,    %% Problem 67
	 preorder/1,                 %% Problem 68
	 inorder/1,                  %% Problem 68
	 full_preorder/1,            %% Problem 68
	 pre_full_tree/1,            %% Problem 68
	 pre_in_tree/2,              %% Problem 68
	 string_stream/1,            %% Problem 68
	 string_stream_value/1,      %% Problem 68
	 string_stream_next/1        %% Problem 68
]).

%% =====================
%% Multiway Tree Exports
%% =====================
-export([is_multi_tree/1,            %% Problem 70B
	 make_multi_tree/1,          %% Problem 70B (unit test)
	 make_multi_tree_fake/1,     %% Problem 70B (unit test)
	 nnodes/1,                   %% Problem 70C
	 multi_tree_2_string/1,      %% Problem 70
	 ipl/1,                      %% Problem 71
	 bottom_up/1                 %% Problem 72
]).

%% ===================== 
%% Miscellaneous Exports
%% ===================== 
-export([queens/1                    %% Problem 90
]).

%% ============= 
%% Documentation
%% ============= 
-export([document/0]).

%%
%% (a) It will mess up our "length" procedure if we import the BIF;
%% (b) Turn off warnings for unused functions;
%%
-compile({no_auto_import, [length/1]}).
-compile({nowarn_unused_function, [{min_nodes, 1},
				   {max_nodes, 1}]}).

%%
%% =============
%%  CHEAT SHEET
%% ============= 
%% 
%% For "solutions" which can be accomplished using a BIF or standard Erlang 
%% library, a "cheat" attribute is attached to the answer as well since, in 
%% the "real" world, we'll want to know and use these more "standardized" tools.
%%

%%
%% =================== 
%%  TERMINATING CASES
%% =================== 
%%
%% Lispers are generally trained to put the "terminating" case "first" in the 
%% code, and in general this is my preference as well. However, Erlang lends 
%% itself so well to an almost "pictorial" style of coding -- in the sense of 
%% "drawing" how the data structures flow through the algorithm -- that for many 
%% of the solutions presented below I place the terminating case at the end, 
%% where it "fits pictorially" more naturally (in terms of the program flow).
%%

%%
%% ======================== 
%%  REVERSING ACCUMULATORS
%% ======================== 
%% 
%% One of the most canonical ways to solve a functional problem is to make 
%% use of an accumulator variable. For many of the problems below, it is more
%% natural to build the accumulator in reverse order, which will save us the 
%% effort of traversing the (increasingly growing) accumulator list each time 
%% we evaluate a new argument. When this pattern is used, we reverse the 
%% accumulator before terminating.
%%

%%
%% ==============================
%%  PART I -- LIST MANIPULATIONS 
%% ==============================
%%

%% =====================================
%% @doc
%% P01 (*) Find the last box of a list.
%% @end
%%
%% Example:
%% > (my-last '(a b c d))
%% > (d)
%%
%% CHEAT: lists:last/1
%% ===================================== 
-spec my_last(List) -> T when 
      List :: [T], 
      T :: term().

my_last(L) when is_list(L) -> my_last(L, []).
my_last([H|T], _) -> my_last(T, H);
my_last([], Acc) -> Acc.

%% =============================================
%% @doc
%% P02 (*) Find the last but one box of a list.
%% @end
%%
%% Example:
%% > (my-but-last '(a b c d)
%% > (c d)
%% =============================================
-spec my_but_last(List) -> T when 
      List :: [T], 
      T :: term().				   

my_but_last(L) when is_list(L) -> my_but_last(L, [], []).
my_but_last([H|T], A, _) -> my_but_last(T, H, A);
my_but_last([], _, A) -> A.

%% ===========================================
%% @doc
%% P03 (*) Find the K'th element of a list.
%%
%% The first element in the list is number 1.
%% @end
%%
%% Example:
%% > (element-at '(a b c d e) 3)
%% > c
%%
%% CHEAT: lists:nth/2
%% ===========================================
-spec element_at(List, N) -> T when 
      List :: [T], N :: pos_integer(), 
      T :: term().

element_at(L, N) when is_list(L), is_integer(N), N > 0 -> element_at(L, N, 1).
element_at([H|_], _N, _N) -> H;
element_at([_|T], N, K) -> element_at(T, N, K+1);
element_at([], _, _) -> {error, out_of_bounds}.

%% ===============================================
%% @doc
%% P04 (*) Find the number of elements in a list.
%% @end
%%
%% CHEAT: length/1 (BIF)
%% ===============================================
-spec length(List) -> non_neg_integer() when 
      List :: [T], T :: term().

length(L) when is_list(L) -> length(L, 0).
length([_|T], Acc) -> length(T, Acc+1);
length([], Acc) -> Acc.

%% ===========================================
%% @doc
%% P05 (*) Reverse a list.
%% 
%% Non-tail-recursive version.
%% @end
%%
%% CHEAT: lists:reverse/1
%% ===========================================
-spec reverse_no_tail(List) -> List when 
      List :: [T], T :: term().

reverse_no_tail([H|T]) -> reverse_no_tail(T) ++ [H];
reverse_no_tail([]) -> [].

%% ===========================================
%% @doc
%% P05 (*) Reverse a list.
%%
%% Tail-recursive version.
%% @end
%%
%% CHEAT: lists:reverse/1
%% =========================================== 
-spec reverse(List) -> List when 
      List :: [T], T :: term().

reverse(L) when is_list(L) -> reverse(L, []).
reverse([H|T], Acc) -> reverse(T, [H|Acc]);
reverse([], Acc) -> Acc.

%% =================================================
%% @doc
%% P06 (*) Find out whether a list is a palindrome.
%%
%% A palindrome can be read forward or backward;
%% e.g., (x a m a x).
%% @end
%% =================================================
-spec palindrome(List) -> boolean() when 
      List :: [T], T :: term(). 

palindrome(L) when is_list(L) ->
    M = reverse(L),
    case L of
        M -> true;
        _ -> false
    end.

%% ===========================================================================
%% @doc
%% P07 (**) Flatten a nested list structure.
%%
%% Transform a list, possibly holding lists as elements into a 'flag' list by
%% replacing each list with its elements (recursively).
%% @end
%%
%% Example:
%% > (my-flatten '(a (b (c d) e)))
%% > (a b c d e)
%%
%% CHEAT: lists:flatten/2
%% ===========================================================================
-spec my_flatten(DeepList) -> List when 
      DeepList :: [term() | DeepList], 
      List :: [term()]. 

my_flatten(L) when is_list(L) -> my_flatten(L, []).
my_flatten([H|T], Acc) when is_list(H) -> 
    my_flatten(T, Acc ++ my_flatten(H, []));
my_flatten([H|T], Acc) -> my_flatten(T, Acc ++ [H]);
my_flatten([], Acc) -> Acc.

%% ===========================================================================
%% @doc
%% P08 (**) Eliminate consecutive duplicates of list elements.
%%
%% If a list contains repeated elements they should be replaced with a single 
%% copy of the element. The order of the elements should not be changed.
%% @end
%%
%% Example:
%% > (compress '(a a a a b c c a a d e e e e))
%% > (a b c a d e)
%% ===========================================================================
%%
%% For "purists" who don't want to fall back on the standard library function 
%% lists:reverse/1, note that we implemented our own version of "reverse" in 
%% P05.
%%
-spec compress(List) -> List when 
      List :: [T], T :: term().

compress(L) when is_list(L) -> compress(L, []).
compress([H|T], []) -> compress(T, [H]);
compress([H|T], [H]) -> compress(T, [H]);
compress([H|T], [A]) -> compress(T, [H] ++ [A]);
compress([H|T], [H|B]) -> compress(T, [H|B]);
compress([H|T], [A|B]) -> compress(T, [H] ++ [A|B]);
compress([], Acc) -> lists:reverse(Acc).

%% =======================================================================
%% @doc
%% P09 (**) Pack consecutive duplicates of list elements into sublists.
%%
%% If a list contains repeated elements they should be placed in separate 
%% sublists.
%% @end
%%
%% Example:
%% > (pack '(a a a a b c c a a d e e e e))
%% > ((a a a a) (b) (c c) (a a) (d) (e e e e))
%% =======================================================================
-spec pack(List) -> DeepList when 
      DeepList :: [List], 
      List :: [term()].

pack(L) when is_list(L) -> pack(L, [], []).
pack([H|T], [], Acc) -> pack(T, [H], Acc);
pack([H|T], [H|A], Acc) -> pack(T, [H] ++ [H|A], Acc);
pack([H|T], [A|B], Acc) -> pack(T, [H], [[A|B]] ++ Acc);
pack([], A, Acc) -> lists:reverse([A] ++ Acc).

%% ============================================================================
%% @doc
%% P10 (**) Run-length encoding of a list.
%%
%% Use the result of P09 to implement the so-called run-length encoding data 
%% compression method. Consecutive duplicates of elements are encoded as lists
%% (N E) where N is the number of duplicates of the element E.
%% @end
%%
%% Example:
%% > (encode '(a a a a b c c a a d e e e e))
%% > ((4 a) (1 b) (2 c) (2 a) (1 d) (4 e))
%% ============================================================================
-spec encode(List) -> DeepList when 
      DeepList :: [List], 
      List :: [term()].

encode(L) when is_list(L) -> encode(L, [], []).
encode([H|T], [], Acc) -> encode(T, [1,H], Acc);
encode([H|T], [N,H], Acc) -> encode(T, [N+1,H], Acc);
encode([H|T], A, Acc) -> encode(T, [1,H], [A] ++ Acc);
encode([], A, Acc) -> lists:reverse([A] ++ Acc).

%% =========================================================================
%% @doc
%% P11 (*) Modified run-length encoding.
%%
%% Modify the result of problem P10 in such a way that if an element has no 
%% duplicates it is simply copied into the result list. Only elements with 
%% duplicates are transferred as (N E) lists.
%%
%% Implemented using HOPs and lists:map.
%% @end
%%
%% Example:
%% > (encode-modified '(a a a a b c c a a d e e e e))
%% > ((4 a) b (2 c) (2 a) d (4 e))
%% =========================================================================
%%
%% One simple way to implement this is to map a HOF over the solution to the 
%% previous exercise.
%%
%% For "purists" who don't want to fall back on the standard library function 
%% lists:map/2, note that a simple implementation of "map" can be given as:
%%
%% map(F, L) -> map(F, L, []).
%% map(_, [], Acc) -> lists:reverse(Acc);
%% map(F, [H|T], Acc) -> map(F, T, [F(H)|Acc]).
%%
-spec encode_modified1(List) -> DeepList when 
      DeepList :: [term() | List], 
      List :: [term()].

encode_modified1(L) when is_list(L) -> 
    Mapper = fun([H|T]) ->
		     case H of
			 1 -> hd(T);
			 _ -> [H|T]
		     end
             end,
    lists:map(Mapper, encode(L)).

%% =========================================================================
%% @doc
%% P11 (*) Modified run-length encoding.
%%
%% Modify the result of problem P10 in such a way that if an element has no 
%% duplicates it is simply copied into the result list. Only elements with 
%% duplicates are transferred as (N E) lists.
%%
%% Implemented "manually".
%% @end
%%
%% Example:
%% > (encode-modified '(a a a a b c c a a d e e e e))
%% > ((4 a) b (2 c) (2 a) d (4 e))
%% ========================================================================= 
%%
%% We can also code this "by hand" by adding just one more pattern to match:
%%
-spec encode_modified(List) -> DeepList when 
      DeepList :: [term() | List], 
      List :: [term()].

encode_modified(L) when is_list(L) -> encode_modified(L, [], []).
encode_modified([H|T], [], Acc) -> encode_modified(T, H, Acc);
encode_modified([H|T], H, Acc) -> encode_modified(T, [2,H], Acc);
encode_modified([H|T], [N,H], Acc) -> encode_modified(T, [N+1,H], Acc);
encode_modified([H|T], A, Acc) -> encode_modified(T, H, [A] ++ Acc);
encode_modified([], A, Acc) -> lists:reverse([A] ++ Acc).

%% ===============================================================
%% @doc
%% P12 (**) Decode a run-length encoded lists.
%% @end
%%
%% Given a run-length encoded list generated as specified in P11. 
%% Construct its uncompressed version.
%% ===============================================================
-spec decode_modified(DeepList) -> List when 
      DeepList :: [term() | List], 
      List :: [term()].

decode_modified(L) when is_list(L) -> decode_modified(L, []).
decode_modified([H|T], Acc) when is_list(H) -> 
    Num = hd(H), Elem = hd(tl(H)),
    decode_modified(T, Acc ++ duplicate(Num, Elem));
decode_modified([H|T], Acc) -> decode_modified(T, Acc ++ [H]);
decode_modified([], Acc) -> Acc.

%%
%% To make this procedure work, we first need to definea helper "duplicate" 
%% procedure. We'll need this procedure to solve other problems as well, so 
%% let's define and abstract it out here.
%%
%% Note that this is (essentially) identical to lists:duplicate/2:
%%
-spec duplicate(N, T) -> List when 
      List :: [T], T :: term(), 
      N :: non_neg_integer().

duplicate(Num, Elem) when is_integer(Num), Num >= 0 -> duplicate(Num, Elem, []).
duplicate(Num, Elem, Acc) when Num > 0 -> duplicate(Num-1, Elem, [Elem|Acc]);
duplicate(0, _, Acc) -> Acc.

%% ==============================================================================
%% @doc
%% P13 (**) Run-length encoding of a list (direct solution)
%%
%% Implement the so-called run-length encoding data compression method directly,
%% i.e., don't explicitly create the sublists containing the duplicates, as in 
%% P09, but only count them. As in P11, simplify the result list by replacing 
%% the singleton lists (1 X) by X.
%% @end
%%
%% Example:
%% > (encode-direct '(a a a a b c c a a d e e e e)
%% > ((4 a) b (2 c) (2 a) d (4 e))
%% ==============================================================================
-spec encode_direct(List) -> DeepList when 
      DeepList :: [term() | List], 
      List :: [term()].

encode_direct([H|T]) -> encode_direct(T, H, 1, []);
encode_direct([]) -> [].
encode_direct([H|T], H, Num, Acc) -> encode_direct(T, H, Num+1, Acc);
encode_direct([H|T], Elem, 1, Acc) -> encode_direct(T, H, 1, Acc ++ [Elem]);
encode_direct([H|T], Elem, Num, Acc) -> 
    encode_direct(T, H, 1, Acc ++ [[Num, Elem]]);
encode_direct([], Elem, 1, Acc) -> Acc ++ [Elem];
encode_direct([], Elem, Num, Acc) -> Acc ++ [[Num, Elem]].

%% ==================================================================== 
%% @doc
%% P14 (*) Duplicate the elements of a list.
%% @end
%%
%% Example:
%% > (dupli '(a b c c d))
%% > (a a b b c c c c d d)
%%
%% CHEAT: This is similar to (but different from): lists:duplicate/2.
%% ===================================================================
-spec dupli(List) -> List when 
      List :: [term()].

dupli(L) when is_list(L) -> dupli(L,[]).
dupli([H|T], Acc) -> dupli(T, Acc ++ [H,H]);
dupli([], Acc) -> Acc.

%% =================================================================== 
%% @doc
%% P15 (**) Replicate the elements of a list given a number of times.
%% @end
%%
%% Example:
%% > (repli '(a b c) 3)
%% > (a a a b b b c c c)
%%
%% CHEAT: This is similar to (but different from): lists:duplicate/2.
%% =================================================================== 
%%
%% We can utilize the "duplicate/2" helper function we defined above:
%%
-spec repli(List, N) -> List when 
      List :: [term()], 
      N :: non_neg_integer().

repli(L, N) when is_list(L), is_integer(N), N >= 0 -> repli(L, N, []).
repli([H|T], N, Acc) -> repli(T, N, Acc ++ duplicate(N,H));
repli([], _, Acc) -> Acc.

%% ============================================================ 
%% @doc
%% P16 (**) Drop every N'th element from a list.
%% @end
%%
%% Example:
%% > (drop '(a b c d e f g h i j k) 3)
%% > (a b d e g h j k)
%%
%% CHEAT: Similar, albeit different, standard library
%% functions include lists:delete/2 and lists:dropwhile/2.
%% This could even be solved (probably) using lists:filter/2.
%% ============================================================
-spec drop(List, N) -> List when 
      List :: [term()], 
      N :: pos_integer().

drop(L, N) when is_list(L), is_integer(N), N > 0 -> drop(L, N, 1, []).
drop([_|T], N, N, Acc) -> drop(T, N, 1, Acc);
drop([H|T], N, Count, Acc) -> drop(T, N, Count+1, Acc ++ [H]);
drop([], _, _, Acc) -> Acc.

%% ============================================================================
%% @doc
%% P17 (*) Split a list into two parts; the length of the first part is given.
%% 
%% Do not use any predefined predicates.
%% @end
%%
%% Example:
%% > (split '(a b c d e f g h i j k) 3)
%% > ((a b c) (d e f g h i j k))
%%
%% CHEAT: This is essentially identical to lists:split/2.
%% ============================================================================ 
-spec split(List, N) -> {List,List} when 
      List :: [term()], 
      N :: non_neg_integer().

split(L, N) when is_list(L), is_integer(N), N >= 0 -> split(L, N, 0, []).
split(L, N, N, Acc) -> {Acc, L}; 
split([H|T], N, Count, Acc) -> split(T, N, Count+1, Acc ++ [H]);
split([], _, _, Acc) -> {Acc,[]}.

%% ==============================================================================
%% @doc
%% P18 (**) Extract a list from a list.
%%
%% Given two indices, I and K, the slice is the list containing the elements
%% between the Ith and Kth elements of the origianl list (both limits included).
%% Start counting the elements with 1.
%% @end
%%
%% Example:
%% > (slice '(a b c d e f g h i j k) 3 7)
%% > (c d e f g)
%% ==============================================================================
-spec slice(List, N, N) -> List when 
      List :: [term()], 
      N :: pos_integer().

slice([], _, _) -> [];
slice(L, I, K) when is_list(L), 
		    is_integer(I), 
		    is_integer(K), 
		    I > 0, 
		    K > 0, 
		    K >= I -> 
    case A = element_at(L,I) of
        {error,out_of_bounds} -> [];
        _ -> slice(L, I, K, I+1, [A])
    end.
slice(L, I, K, Count, Acc) when K >= Count ->
    case A = element_at(L,Count) of
        {error,out_of_bounds} -> Acc;
        _ -> slice(L, I, K, Count+1, Acc ++ [A])
    end;
slice(_, _, _, _, Acc) -> Acc.

%% ============================================================================
%% @doc
%% P19 (**) Rotate a list N places to the left.
%% @end
%%
%% Examples:
%% > (rotate '(a b c d e f g h) 3)
%% > (d e f g h a b c)
%%
%% > (rotate '(a b c d e f g h) -2)
%% > (g h a b c d e f)
%%
%% Hint: Use the predefined functions length and append, as well as the result
%% of problem P17.
%% ============================================================================ 
-spec rotate(List, N) -> List when 
      List :: [term()], 
      N :: integer().

rotate(L, N) when is_list(L), is_integer(N) -> 
    A = split(L, mod(N, length(L))),
    element(2,A) ++ element(1,A).

%% 
%% We need a "mod" function to support the "rotate" procedure above:
%%
mod(X,Y) when X > 0 -> X rem Y;
mod(X,Y) when X < 0 -> Y + X rem Y;
mod(0,_) -> 0. 

%% ===============================================
%% @doc
%% P20 (*) Remove the K'th element from a list.
%% @end
%%
%% Example:
%% > (remove-at '(a b c d) 2)
%% > (a c d)
%% 
%% CHEAT: Simiar to lists:delete/2.
%% =============================================== 
-spec remove_at(List, N) -> List when 
      List :: [term()], 
      N :: pos_integer().

remove_at(L, N) when is_list(L), is_integer(N), N > 0 -> 
    remove_at(L, N, length(L)).
remove_at(L, N, Len) when N > Len -> L;
remove_at(L, N, _) ->
    SplitList = split(L, N),
    FirstList = element(1, SplitList),
    DeletedList = drop(FirstList, length(FirstList)),
    DeletedList ++ element(2, SplitList).
    
%% =============================================================
%% @doc
%% P21 (*) Insert an element at a given position into a list.
%% @end
%%  
%% Example:
%% > (insert-at 'alfa '(a b c d) 2)
%% > (a alfa b c d)
%% =============================================================
-spec insert_at(Token, List, N) -> List when 
      Token:: term(), 
      List ::[term()], 
      N :: pos_integer().

insert_at(T, L, N) when is_list(L), is_integer(N), N > 0 ->
    {Front, Back} = split(L, N-1),
    Front ++ [T] ++ Back.  

%% ==============================================================================
%% @doc
%% P22 (*) Create a list containing all integers within a given range.
%%
%% If the first argument is larger than the second, produce a list in decreasing 
%% order.
%% @end
%%
%% Example:
%% > (range 4 9)
%% > (4 5 6 7 8 9)
%% ==============================================================================
-spec range(N, M) -> List when 
      N :: integer(), 
      M ::integer(), 
      List :: [term()].

range(N, M) when N < M, is_integer(N), is_integer(M) -> range(N, M, up, []);
range(N, M) when is_integer(N), is_integer(M)  -> range(N, M, down, []).

range(N, N, _, Acc) -> Acc ++ [N];
range(N, M, up, Acc) -> range(N+1, M, up, Acc ++ [N]);
range(N, M, down, Acc) -> range(N-1, M, down, Acc ++ [N]).

%% ===========================================================================
%% @doc
%% P23 (**) Extract a given number of randomly selected elements from a list.
%%
%% The selected items shall be returned in a list.
%% @end
%%
%% Example:
%% > (md-select '(a b c d e f g h) 3)
%% > (e d a)
%%
%% Hint: Use the built-in random number generator and the result of P20.
%% ===========================================================================
-spec md_select(List, N) -> List when 
      List :: [term()], 
      N :: pos_integer().

md_select(List, N) when is_list(List), 
			is_integer(N), 
			N > 0, 
			N =< erlang:length(List) -> 
    random:seed(now()),
    md_select(List, N, 0, []).

md_select(_, N, N, Acc) -> Acc;
md_select(List, N, Count, Acc) ->
    K = random:uniform(length(List)),
    NewElement = lists:nth(K, List),
    NewList = remove_at(List, K),
    md_select(NewList, N, Count+1, [NewElement|Acc]).

%% ===================================================================== 
%% @doc
%% P24 (*) Lotto: Draw N different random numbers from the set 1 .. M. 
%% 
%% The selected numbers shall be returned in a list.
%% @end
%%
%% Example:
%% > (lotto-select 6 49)
%% > (23 1 17 33 21 37)
%% 
%% Hint: Combine the solutions of problems P22 and P23.
%% =====================================================================
-spec lotto_select(N, Size) -> List when 
      N :: pos_integer(), 
      Size :: pos_integer(), 
      List :: [term()].

lotto_select(N, Size) when is_integer(N), 
			   is_integer(Size), 
			   N > 0, 
			   Size > 0, 
			   N =< Size ->
    Sample = range(1, Size),
    md_select(Sample, N).

%% =================================================================
%% @doc 
%% P25 (*) Generate a random permutation of the elements of a list. 
%% @end
%%
%% Example:
%% > (md-permu '(a b c d e f))
%% > (b a d c e f)
%%
%% Hint: Use the solutions of problem P23.
%% =================================================================
-spec md_permu(List) -> List when 
      List :: [term()].

md_permu(List) when is_list(List) ->
    md_select(List, length(List)).

%% =============================================================================
%% @doc
%% P26 (**) Generate the K distinct combinations chosen from a set of N objects.
%%
%% In how many ways can a committee of 3 be chosen from a group of 12 people? We 
%% all know that there are C(12,3) = 220 possibilities. For pure mathematicians, 
%% this result may be great. But we want to really generate all the possibilities 
%% in a list.
%% @end
%%
%% Example:
%% > (combinations 3 '(a b c d e f))
%% > ((a b c) (a b d) (a b e) ...)
%% =============================================================================
-spec combinations(N, List) -> DeepList when 
      N :: non_neg_integer(),
      List :: [term()],
      DeepList :: [term() | DeepList].
      
combinations(0, _) -> [[]];
combinations(_, []) -> [[]];
combinations(N, List) when is_integer(N), 
			   is_list(List), 
			   N =:= erlang:length(List) -> [List];
combinations(N, List) when is_integer(N), 
			   is_list(List), 
			   N  < erlang:length(List) ->
    %% Find the sub-combinations, beginning at the given index
    SubCombos = fun(Index) ->
			Elem = element_at(List, Index),
			SubList = lists:sublist(List, 
						Index+1, 
						length(List)-Index+1),
			lists:map(fun(X) -> [Elem] ++ X end, 
				  combinations(N-1, SubList))
		end,
    unpack([SubCombos(Index) || Index <- range(1, length(List) - N + 1)]).
     
%%
%% Helper function for the "combinations" procedure above, to "unpack" a 
%% collection of lists into a single master list (similar to the "flatten" or 
%% "my-flatten" procedures above, but we want to start the flattening process 
%% at just one level of recursion.
%%
-spec unpack(DeepList) -> DeepList when
      DeepList :: [term() | DeepList].

unpack(L) -> unpack(L, []).
unpack([], Acc) -> Acc;
unpack([H|T], Acc) -> unpack(T, lists:append(Acc, H)).

%% ==============================================================================
%% @doc
%% P27A (**) Group the elements of a set into disjoint subsets.
%%
%% (a) In how many ways can a group of 9 people work in 3 disjoint subgroups of 
%% 2, 3 and 4 persons? Write a function that generates all the possibilities and 
%% returns them in a list.
%% @end
%%
%% Example A:                                                                                                  
%% > (group3 '(aldo beat carla david evi flip gary hugo ida))                                
%% > ((aldo beat) (carla david evi) (flip gary hugo ida) ...)  
%% ==============================================================================
-spec group3(List) -> DeepList when
      List :: [term()],
      DeepList :: [term() | DeepList].

group3(L) when is_list(L) -> 
    %%
    %% Recursive walk to calculate the combinations, generates a folded 
    %% collection of tuples, Invoke helper "unfold" procedure to unfold the 
    %% tuples.
    %%
    Comb1 = fun(X) ->
		    Comb2 = fun(Y) -> { Y, (L -- X) -- Y } end,
		    { X, lists:map(Comb2, combinations(3, L -- X)) }
	    end,
    unfold(lists:map(Comb1, combinations(2, L)), []).

%%
%% Helper functions to "unfold" the tuples generated in the "group3" procedure 
%% above.
%%
-spec unfold(List, DeepList) -> DeepList when
      List :: [term()],
      DeepList :: [term() | DeepList].

unfold([], Acc) -> Acc;
unfold([H|T], Acc) -> 
    A = element(1, H),
    B = element(2, H),
    unfold(T, Acc ++ unfold_iter(A, B, [])).

-spec unfold_iter(List, List, DeepList) -> DeepList when
      List :: [term()],
      DeepList :: [term() | DeepList].

unfold_iter(_, [], Acc) -> Acc;
unfold_iter(Prefix, [H|T], Acc) -> 
    unfold_iter(Prefix, T, Acc ++ [[Prefix, element(1,H), element(2,H)]]).
     
%% ==============================================================================
%% @doc
%% P27B (**) Group the elements of a set into disjoint subsets.
%%
%% (b) Generalize the above predicate in a way that we can specify a list of 
%% group sizes and the predicate will return a list of groups. 
%% @end
%%
%% Example B:
%% > (group '(aldo beat carla david evi flip gary hugo ida) '(2 2 5))
%% > (((aldo beat) (carla david) (evi flip gary huge ida)) ...)
%%
%% Note that we do not want permutations of the group members, i.e., 
%% ((aldo beat) ...) is the same solution as ((beta aldo) ...), however we make 
%% a difference between ((aldo beat) (carla david) ...) and
%% ((carla david) (aldo beat) ...).
%%
%% You may find more about this combinatorial problem in a good book on discrete 
%% mathematics under the term "multinomial coefficients".
%% ==============================================================================
%%
%% I'm going to go forward with the presumption that we'll be dividing the list
%% into precisely three groups, and all that changes from part (a) is that the 
%% number of elements in each group is now variable. 
%%
%% This means that we can essentially re-use (with only slight modifications) 
%% the solution that we derived above.
%%
%% If we were to require in addition that a variable number of subgroups, each 
%% of variable size, could be specified, we would have to go back and re-work 
%% this solution considerably.
%%
-spec group(List1, List2) -> DeepList when 
      List1 :: [term()],
      List2 :: [pos_integer()],
      DeepList :: [term() | DeepList].

group(L, [A, B, C]) when is_list(L), 
			 is_integer(A), 
			 is_integer(B), 
			 is_integer(C), 
			 A > 0, 
			 B > 0, 
			 C > 0, 
			 A + B + C =:= 9 ->
    Comb1 = fun(X) ->
		    Comb2 = fun(Y) -> { Y, (L--X) -- Y } end,
		    { X, lists:map(Comb2, combinations(B, (L--X))) }
            end,
    unfold(lists:map(Comb1, combinations(A, L)), []).

%% ==============================================================================
%% @doc
%% P28A (**) Sorting a list of lists according to length of sublists.
%%
%% (a) We suppose that a list contains elements that are lists themselves. The 
%% objective is to sort the elements of this list according to their length. 
%% e.g., short lists first, longer lists later, or vice versa.
%% @end
%%
%% Example A:                                                                                                              
%% > (lsort '((a b c) (d e) (f g h) (d e) (i j k l) (m n) (o)))                       
%% > ((o) (d e) (d e) (m n) (a b c) (f g h) (i j k l))    
%% ==============================================================================
%%
%% See discussion below for explanation of how this is implemented: 
%%
-spec lsort(List) -> List when
      List :: [term() | List].

lsort(L) when is_list(L) -> sort(L, fun sort_predicate/2).

%%
%% We need a "quick and dirty" sorting procedure to implement P28. We give a 
%% standard, textbook implementation of QuickSort below. Code of this style is 
%% frequently cited as an example of the expressive power (or perhaps, of the 
%% expressive terseness) of Erlang. Note that it's NOT tail recursive, and hence
%% should probably NOT be used in a production setting:
%%
-spec sort(List, Predicate) -> List when
      List :: [term() | List],
      Predicate :: fun().

sort([], _Predicate) -> [];
sort([H|T], Predicate) -> 
    sort([X || X <- T, Predicate(X,H)], Predicate)
    ++ [H] ++
    sort([X || X <- T, not Predicate(X,H)], Predicate).

%%
%% The "predicate" term above lets us define custom sort predicates/metrics for
%% how to arrange the elements of the target set.
%%
%% A standard, example predicate might look something like:
%%
%%  sort_predicate(A, B) -> A =< B.
%%
%% This will arrange the elements of the set in increasing order.
%%
%% We define the following predicate for sorting for P28:
%%
-spec sort_predicate(T, T) -> boolean() when
      T :: [term() | [term()]].

sort_predicate(A,B) when is_list(A), is_list(B) -> length(A) < length(B).

%%
%% We keep the ordering metric above "strictly less than" to preserve "in place"
%% sorting here.
%%
      
%% ===============================================================================
%% @doc
%% P28B (**) Sorting a list of lists according to length of sublists.
%%
%% (b) Again, we suppose that a list contains elements that are lists themselves. 
%% But this time the objective is to sort the elements of this list according to 
%% their length frequency; i.e., in the default, where sorting is done 
%% ascendingly, lists with rare lengths are placed first, others with a more 
%% frequent length come length.
%% @end
%%
%% Example B:
%% > (lfsort '((a b c) (d e) (f g h) (d e) (i j k l) (m n) (o)))
%% > ((i j k l) (o) (a b c) (f g h) (d e) (d e) (m n))
%%
%% Note that in the above example, the first two lists in the result have length 
%% 4 and 1, both lengths appear just once. The third and fourth lists have length 
%% 3 which appears twice (there are two lists of this length). And finally, the 
%% last three lengths have length 2. This is the most frequent length.
%% ===============================================================================
%%
%% See discussion below for explanation of how this is implemented:
%%
-spec lfsort(List) -> List when
      List :: [term() | List].

lfsort(L) when is_list(L) ->
    Sort = make_sort_predicate(L),
    sort(L, Sort).

%%
%% Let's use an auxilliary data structure (i.e., an orddict) to 
%% keep track of the frequency of the length of each list item:
%%
-spec counter(List) -> [{Key,Val}] when 
      List :: [term() | List],
      Key :: term(),
      Val :: term().

counter(L) when is_list(L) -> counter(L, orddict:new()).
counter([], Acc) -> Acc;
counter([H|T], Acc) -> 
    Len = length(H),
    case orddict:is_key(Len, Acc) of
        true -> Value = orddict:fetch(Len, Acc);
        false -> Value = 0
    end,
    counter(T, orddict:store(Len, Value+1, Acc)).

%%
%% We need a sort predicate that utilizes the data structure we constructed 
%% above; Let's do it using a closure:
%%    
-spec make_sort_predicate(List) -> fun() when
      List :: [term() | List].

make_sort_predicate(L) when is_list(L) ->
    Counter = counter(L),
    fun(A,B) when is_list(A), is_list(B) ->
	    ValA = orddict:fetch(length(A), Counter),
	    ValB = orddict:fetch(length(B), Counter),   
	    ValA < ValB
    end.

%%
%% =======================
%%  PART II -- ARITHMETIC
%% =======================
%%

%% ============================================================ 
%% @doc
%% P31 (**) Determine whether a given integer number is prime.
%% @end
%%
%% Example:
%% > (is-prime 7)
%% > true
%% ============================================================ 
%%
%% One way to test whether a number is prime is to determine whether it is 
%% equal to its own smallest divisor. The procedure below will return the 
%% smallest divisor of N:
%%
-spec smallest_divisor(N) -> M when 
      N :: pos_integer(),
      M :: pos_integer().

smallest_divisor(N) when is_integer(N), N > 0 -> find_divisor(N,2).

%%
%% Given arguments N and Test, the procedure terminates and returns Test if 
%% Test is a divisor of N. Otherwise, it recursively calls itself testing the 
%% next possible divisor. If value of Test is larger than the square root of N,
%% we terminate and return N as the solution.
%%
-spec find_divisor(X, Y) -> Z when
      X :: pos_integer(),
      Y :: pos_integer(),
      Z :: pos_integer().

find_divisor(N, Test) when is_integer(N), 
			   is_integer(Test), 
			   Test * Test > N -> N;
find_divisor(N, Test) when is_integer(N), 
			   is_integer(Test), 
			   (N rem Test) =:= 0 -> Test;
find_divisor(N, Test) when is_integer(N), 
			   is_integer(Test) -> 
    Next = fun() when Test =:= 2 -> 3;
	      () -> Test + 2
           end,
    find_divisor(N, Next()).

%% 
%% With these supporting functions defined, the "is_prime" predicate is 
%% easily defined as being true when the argument N is equal to its own 
%% smallest divisor:
%%
-spec is_prime(N) -> T when
      N :: pos_integer(),
      T :: boolean().

is_prime(1) -> false;
is_prime(N) when is_integer(N), N > 1 -> N =:= smallest_divisor(N).

%%
%% Another (faster) way to perform primality testing is to use a stochastic
%% algorithm based on Fermat's Little Theorem: In n is a prime number and a 
%% is any positive integer less than n, then a raised to the n-th power is 
%% congruent to a modulo n.
%%
%% The details of this technique are given in the MIT SICP text, Section 1.2.
%%
%% We give an Erlang implementation below:
%%

%%
%% First we require a "square" procedure:
%%
-spec square(N) -> M when
      N :: pos_integer(),
      M :: pos_integer().

square(N) when is_integer(N) -> N * N.

%%
%% The "expmod" procedure calculates the exponent of a number modulo 
%% another number:
%%
-spec expmod(B, E, M) -> A when
      B :: pos_integer(),
      E :: pos_integer(),
      M :: pos_integer(),
      A :: pos_integer().

expmod(_, 0, _) -> 1;
expmod(Base, Exp, M) when is_integer(Base), 
			  is_integer(Exp), 
			  is_integer(M), 
			  (Exp rem 2) =:= 0 -> 
    square(expmod(Base, Exp div 2, M)) rem M;
expmod(Base, Exp, M) when is_integer(Base), 
			  is_integer(Exp), 
			  is_integer(M) -> 
    (Base * expmod(Base, Exp-1, M)) rem M.

%%
%% We need a randomly selected integer in the range from 2 to N-3, inclusive.
%%
%% Note that random:uniform(N) is an Erlang library function that returns 
%% a uniformly distributed random number between 1 and N, inclusive.
%%
-spec get_random_a(N) -> N when
      N :: pos_integer().

get_random_a(N) when is_integer(N) ->
    1 + random:uniform(N-4).

%%
%% Use the "expmod" procedure to run a test for primailty:
%%
-spec is_prime_test(N,A) -> T when
      N :: pos_integer(),
      A :: pos_integer(),
      T :: boolean().

is_prime_test(N, A) when is_integer(N), is_integer(A) ->
    expmod(A, N-1, N) =:= 1.

%%
%% The actual stochastic algorithm based on Fermat's Little Theorem follows.
%%
%% Running the stochastic test more and more times will generate greater and 
%% greater bounds of certainty, but we find the running the test three times 
%% gives pretty solid and confident results. We "hard code" the answer for the
%% first five integers.
%%
-spec is_prime1(N) -> T when
      N :: pos_integer(),
      T :: boolean().

is_prime1(N) when N =:= 1 -> false;
is_prime1(N) when N =:= 2 -> true;
is_prime1(N) when N =:= 3 -> true;
is_prime1(N) when N =:= 4 -> false;
is_prime1(N) when N =:= 5 -> true;
is_prime1(N) when N > 5 -> 
    is_prime_test(N, N-1) and
    is_prime_test(N, N-2) and
    is_prime_test(N, get_random_a(N)) and
    is_prime_test(N, get_random_a(N)) and
    is_prime_test(N, get_random_a(N)).
    
%% ============================================================
%% @doc
%% P32 (**) Determine the GCD of two positive integer numbers.
%%
%% Use Euclid's algorithm.
%% @end
%%
%% Example:
%% > (gcd 36 63)
%% > 9
%% ============================================================
-spec gcd(A,B) -> N when
      A :: pos_integer(),
      B :: pos_integer(),
      N :: pos_integer().

gcd(A,0) when is_integer(A) -> A;
gcd(A,B) when is_integer(A), is_integer(B) -> gcd(B, A rem B).

%% =====================================================================
%% @doc
%% P33 (*) Determine whether two positive integer numbers are coprime.
%% 
%% Two numbers are coprime if their greatest common divisor equals 1.
%% @end
%%
%% Example:
%% > (coprime 35 64)
%% > true
%% =====================================================================
-spec coprime(A,B) -> T when
      A :: pos_integer(),
      B :: pos_integer(),
      T :: boolean().

coprime(A,B) when is_integer(A), is_integer(B) -> gcd(A,B) =:= 1.

%% =============================================================================
%% @doc
%% P34 (**) Calculate Euler's totient function phi(m).
%%
%% Euler's so-called totient function phi(m) is defined as the number of 
%% positive integers r (1 <= r < m) that are coprime to m. 
%% @end
%%
%% Example: m = 10; r = 1, 3, 7, 9; thus phi(m) = 4. 
%%
%% > (totient-phi 10)
%% > 4
%% 
%% (Note the special case phi(1) = 1).
%% 
%% Find out what the value of phi(m) is if m is a prime number. Euler's totient 
%% function plays an important role in one of the most widely used public key 
%% cryptography methods (RSA). In this exercise, you should use the most 
%% primitive method to calculate this function (there are smarter ways that we 
%% shall discuss later).
%% =============================================================================
-spec totient_phi(N) -> M when
      N :: pos_integer(),
      M :: pos_integer().
			   
totient_phi(M) when is_integer(M), M > 0 ->    
    length( lists:filter(fun(N) -> coprime(N,M) end, lists:seq(1,M)) ).
		     
%% ======================================================================== 
%% @doc
%% P35 (**) Determine the prime factors of a given positive integer.
%%
%% Construct a flat list containing the prime factors in ascending order.
%% @end
%%
%% Example:
%% > (prime-factors 315)
%% > (3 3 5 7)
%% ======================================================================== 
%%
%% The following is a simple, "naive" algorithm for finding the prime factors
%% of (comparatively) small integers. For larger integers, an algorithm like
%% the quadratic sieve, invented by Carl Pomerance in 1981, would be more 
%% effective. QS is a faster, effective procedure for calculating prime factors
%% for numbers up to (roughly) 100 digits in length.
%%
-spec prime_factors(N) -> [N] when
      N :: pos_integer().

prime_factors(N) when is_integer(N), N > 1 ->
    %% seperate 2 out as a special factor, so we can increment more efficiently
    PrimeFactorsIter = fun(_, M, Acc, _Func) when (M =:= 0) or (M =:= 1) -> Acc;
			  (2, M, Acc, Func) when M rem 2 =:= 0 ->
			       Func(2, M div 2, Acc ++ [2], Func);
			  (2, M, Acc, Func) when M rem 2 =/= 0 ->
			       Func(3, M, Acc, Func);
			  (D, M, Acc, Func) when M rem D =:= 0 ->
			       Func(D, M div D, Acc ++ [D], Func);
			  (D, M, Acc, Func) when M rem D =/= 0 ->
			       Func(D+2, M, Acc, Func)
		       end,
    PrimeFactorsIter(2, N, [], PrimeFactorsIter).

%% =========================================================================
%% @doc
%% P36 (**) Determine the prime factors of a given positive integer (2).
%% 
%% Construct a list containing the prime factors and their multiplicity.
%% @end
%%
%% Example:
%% > (prime-factors-mult 315)
%% > ((3 2) (5 1) (7 1))
%% 
%% Hint: The problem is similar to problem P13.
%% ========================================================================= 
%%
%% Actually, the problem is more similar to Problem P11, but in P11 the results
%% are returned in the opposite order from which we are seeking. In other words, 
%% we could implement something like:
%%
%% prime_factors_mult(N) -> encode( prime_factors(N) ).
%%
%% But the result would be something like:
%%
%% > prime_factors_mult(315)
%% > [[2,3], [1,5], [1,7]]
%%
%% In other words, each sublist would be in the reverse order from what we are
%% seeking. Instead, let's just define our own anonymous fun, similar to that in 
%% P11, but which returns the elements in the proper order:
%%
-spec prime_factors_mult(N) -> List when
      N :: pos_integer(),
      List :: [term | List].

prime_factors_mult(N) when is_integer(N), N > 1 ->    
    %%
    %% The "Encode" fun defined here is essentially P11, 
    %% just tweaked to fit our requirements here:
    %%
    Encode = fun([H|T], [], Acc, Func) -> Func(T, [H,1], Acc, Func);
		([H|T], [H,M], Acc, Func) -> Func(T, [H,M+1], Acc, Func);
		([H|T], A, Acc, Func) -> Func(T, [H,1], [A] ++ Acc, Func);
		([], A, Acc, _Func) -> lists:reverse([A] ++ Acc)
             end,
    Encode( prime_factors(N), [], [], Encode ).

%% ==============================================================================
%% @doc
%% P37 (**) Calculate Euler's totient function phi(m) (improved).
%%
%% See problem P34 for the definition of Euler's totient function. If the list 
%% of the prime factors of a number M is known in the form of problem P36 then 
%% the function phi(m) can be efficiently calculated as follows: Let ((p1 m1) 
%% (p2 m2) (p3 m3) ..) be the list of prime factors (and their multiplicities) 
%% of a given number M. Then phi(m) can be calculated with the following formula:
%%
%% phi(m) = (p1-1) * p1 ** (m1-1) * (p2-1) * p2 ** (m2-1) * (p3-1) * p3 ** (m3-1) * ...
%%
%% Note that a ** b stands for the b'th power of a.
%% @end
%% ==============================================================================
-spec totient_phi_improved(N) -> M when
      N :: pos_integer(),
      M :: pos_integer().

totient_phi_improved(N) when is_integer(N), 
			     N > 0 ->
    Mapper = fun([H|T]) -> (H-1) * math:pow(H,hd(T)-1) end,
    trunc(lists:foldl(fun(X, Prod) -> X * Prod end, 
		      1, 
		      lists:map(Mapper, prime_factors_mult(N)))).

%% ==============================================================================
%% @doc
%% P38 (*) Compare the two methods of calculating Euler's totient function.
%% 
%% Use the solutions of problems P34 and P37 to compare the algorithms. Take the 
%% number of logical inferences as a measure for efficiency. Try to calculate 
%% phi(10090) as an example.
%% @end
%% ==============================================================================
%%
%% It's not totally clear to me how to adapt either of these procedures to count 
%% the number of logical inferences, so let's just use old fashioned timers. The 
%% second "improved" algorithm depends upon the prime factorization procedure. 
%% For very small M, the performance of the first totient function actually 
%% (slightly) outperforms that of the second, but asymptotically, the second 
%% totient function utilizing prime factorization far outperforms the first.
%%
%% Running statistics on M = 10, 100 and 1000 respectively yields the following 
%% results:
%%
%% > Answer: 4 (9), 4 (17)
%% > Answer: 40 (50), 40 (19)
%% > Answer: 400 (551), 400 (13)
%%
%% Response times are given in microseconds. Hence, for M = 10, the first procedure 
%% took 9 microseconds to complete, while the second "improved" procedure took 17 
%% microseconds. Clearly, the second algorithm is asymptotically superior. 
%%
%% Running the statistics on 10090 as suggested above yields the following results:
%%
%% > Answer: 4032 (3754), 4032 (40)
%%
%% That is, the first algorithm took 3,754 microseconds to execute, while the second 
%% required only 40 microseconds(!).
%%
-spec totient_phi_compare(N) -> no_return() when
      N :: pos_integer().
				    
totient_phi_compare(N) when is_integer(N), N > 0 ->
    %% Performance numbers are given in micro (not milli!) seconds.
    {Time1, Val1} = timer:tc(p99, totient_phi, [N]),
    {Time2, Val2} = timer:tc(p99, totient_phi_improved, [N]),
    io:format("Answer: ~p (~p), ~p (~p)~n", [Val1, Time1, Val2, Time2]).

%% ==============================================================================
%% @doc
%% P39 (*) A list of prime numbers.
%%
%% Given a range of integers by its lower and upper limit, construct a list of 
%% all prime numbers in that range.
%% @end
%% ==============================================================================
-spec prime_number_list(Low, High) -> List when
      Low :: pos_integer(),
      High :: pos_integer(),
      List :: [term()].

prime_number_list(Low, High) when 
      is_integer(Low),
      is_integer(High),
      Low > 0, 
      High >= Low ->    
    lists:filter(fun p99:is_prime/1, lists:seq(Low, High)).

%% ==============================================================================
%% @doc
%% P40 (**) Goldbach's Conjecture.
%% 
%% Goldbach's conjecture says that every positive even number greater than 2 is
%% the sum of two prime numbers. Example, 28 = 5 + 23. It is one of the most 
%% famous facts in number theory that has not been proven to be correct in the 
%% general case. It has been numerically confirmed up to very large numbers 
%% (much larger than we can go with our Prolog system). Write a predicate to 
%% find the two prime numbers that sum up to a given even integer.
%% @end
%%
%% > (goldbach 28)
%% > (5 23)
%% ==============================================================================
-spec goldbach(N) -> tuple() when 
      N :: pos_integer().

goldbach(N) when is_integer(N), N > 2, N rem 2 =:= 0 ->
    Primes = prime_number_list(2, N div 2),
    GoldbachIter = fun([], _) -> [];
		      ([H|T], Func) ->
			   case {is_prime(H), is_prime(N-H)} of
			       {true, true} -> {H, N-H};
			       _  -> Func(T, Func)
                           end
		   end,
    GoldbachIter(Primes, GoldbachIter).

%% ============================================================================
%% @doc
%% P41A (**) A list of Goldbach compositions.
%% 
%% Given a range of integers by its lower and upper limit, print a list of all
%% even numbers and their Goldbach composition.
%% @end
%% 
%% Example:
%% > (goldbach-list 9 20)
%% 10 = 3 + 7
%% 12 = 5 + 7
%% 14 = 3 + 11
%% 16 = 3 + 13
%% 18 = 5 + 13
%% 20 = 3 + 17
%% ============================================================================
-spec goldbach_list(Low, High) -> no_return() when
      Low :: pos_integer(),
      High :: pos_integer().

goldbach_list(Low, High) when 
      is_integer(Low),
      is_integer(High),
      Low > 0, 
      High >= Low ->
    Evens = lists:filter(fun (X) -> (X rem 2 =:= 0) and (X > 2) end, 
			 lists:seq(Low, High)),
    Mapper = fun(X) ->
		 {A,B} = goldbach(X),
	         io:format("~p = ~p + ~p~n",[X, A, B])
	     end,
    lists:map(Mapper, Evens).

%% ==============================================================================
%% @doc
%% P41B (**) A list of Goldbach compositions.
%%
%% In most cases, if an even number is written as the sum of two prime numbers, 
%% one of them is very small. Very rarely, the primes are both bigger than say 
%% 50. Try to find out how many such cases there are in the range 2 ... 3000.
%% @end
%% ==============================================================================
%%
%% To implement this, all we need to do is adjust the "Mapper" procedure in the 
%% solution above:
%%
-spec goldbach_list(Low, High, Limit) -> no_return() when
      Low :: pos_integer(),
      High :: pos_integer(),
      Limit :: pos_integer().

goldbach_list(Low, High, Limit) when 
      is_integer(Low),
      is_integer(High),
      is_integer(Limit),
      Low > 0, 
      High >= Low, 
      Limit > 0 ->
    Evens = lists:filter(fun(X) -> (X rem 2 =:= 0) and (X > 2) end, 
			 lists:seq(Low, High)),
    Mapper = fun(X) ->
	         {A,B} = goldbach(X),
		 case A >= Limit of
		     true -> io:format("~p = ~p + ~p~n", [X, A, B]);
		     false -> ok			    
                 end    
             end,
    lists:map(Mapper, Evens).

%%
%% =============================
%%  Part III -- LOGIC AND CODES
%% =============================
%%

%% ==============================================================================
%% @doc 
%% P46 (**) Truth tables for logical expressions.
%% 
%% Define predicates and/2, or/2, nand/2, nor/2, xor/2, impl/2 and equ/2 (for 
%% logical equivalence) which succeed or fail according to the result of their 
%% respective operations; e.g., and(A,B) will succeed if and only if both A and 
%% B succeed. Note that A and B can be Prolog goals (not only the constants 
%% true and fail).
%%
%% A logical expression in two variables can then be written in prefix notation, 
%% as in the following example: and(or(A,B), nand(A,B)).
%% @end
%%
%% Example:
%% > table(A, B, and(A, or(A, B)))
%% 
%%  true true true
%%  true fail true
%%  fail true fail
%%  fail fail fail
%% ==============================================================================
%%
%% The following three exercises are essentially an exercise in meta-linguistic 
%% programming. We start by defining the basic logic predicates.
%%
%% We define the logic predicates by basically specifying the truth table directly. 
%% We could, of course, define the predicates in a more "Erlang"-esque, "lazy" and 
%% "quick to fail" type way, for instance, as follows:
%%
%%  b_and(true, true) -> true;
%%  b_and(_,_) -> false.
%%
%% But then we would have to contend with such syntatic contortions as 
%% b_and(1,2) =:= false.
%%
%% To eliminate these kinds of abuses, and enforce some basic notion of "typing", 
%% we will specify the truth tables directly by enumerating all four combinations 
%% of boolean arguments.
%%

%% We name this procedure "boolean and" since "and" is a reserved word in Erlang
-spec b_and(A, B) -> C when A :: boolean(), B :: boolean(), C :: boolean().
     
b_and(true, true)   -> true;
b_and(false, true)  -> false;
b_and(true, false)  -> false;
b_and(false, false) -> false.

%% We name this procedure "boolean or" since "or" is a reserved word in Erlang
-spec b_or(A, B) -> C when A :: boolean(), B :: boolean(), C :: boolean().

b_or(true, true)    -> true;
b_or(true, false)   -> true;
b_or(false, true)   -> true;
b_or(false, false)  -> false.

-spec n_and(A, B) -> C when A :: boolean(), B :: boolean(), C :: boolean().

n_and(true, true)   -> false;
n_and(false, true)  -> true;
n_and(true, false)  -> true;
n_and(false, false) -> true.

-spec n_or(A, B) -> C when A :: boolean(), B :: boolean(), C :: boolean().
     
n_or(true, true)    -> false;
n_or(true, false)   -> false;
n_or(false, true)   -> false;
n_or(false, false)  -> true.

-spec x_or(A, B) -> C when A :: boolean(), B :: boolean(), C :: boolean().			    
			    
x_or(true, true)    -> false;
x_or(true, false)   -> true;
x_or(false, true)   -> true;
x_or(false, false)  -> false.

-spec impl(A, B) -> C when A :: boolean(), B :: boolean(), C :: boolean().

impl(true, true)    -> true;
impl(true, false)   -> false;
impl(false, true)   -> true;
impl(false, false)  -> true.

-spec equ(A, B) -> C when A :: boolean(), B :: boolean(), C :: boolean().

equ(true, true)     -> true;
equ(true, false)    -> false;
equ(false, true)    -> false;
equ(false, false)   -> true.

%%
%% We have to make several changes to get the code to work in Erlang. The 
%% way we'll implement it is to have one procedure, table/1, which takes 
%% an "Erlang"-style expression, that is, an expression which terminates 
%% in a period (this will make it easier for us to parse). We'll do a little 
%% bit of syntatic transformation on the argument expression, and map it to the 
%% procedures we have defined above. Parsing of the "and" and "or" predicates is 
%% slightly complicated because we don't want the regular expression to hit 
%% "nand" or "nor" by mistake.
%%
%% The expression must be supplied in the form of a string (i.e., list).
%%
%% Valid "operations" supported by the parser are: "and", "or", "nand", "nor", 
%% "xor", "impl" and "equ".
%%
%% The procedure is designed so that valid arguments to its operations will be 
%% either 'A' or 'B'. However, it is possible to invoke the procedure using the 
%% atoms 'true' or 'false'. However, if you do so, note that the table outputs 
%% three values: one column for 'A', one column for 'B', and the third value 
%% giving the value of what the expression evaluates to. If you "hide" either 'A' 
%% or 'B' by supplying the atoms 'true' or 'false' instead, then some of the 
%% information in the first two columns may loss its meaning. The value of the 
%% third column, however, will still give the appropriate evaluated value for the 
%% expression you supply.
%%
%% Some simple examples of valid ways to invoke the procedure:
%%
%% > p99:table("and(A,B).").
%% > p99:table("and(true,B).").
%% > p99:table("and(A,or(A,B)).").
%% > p99:table("and(or(A,B),nand(A,B)).").
%% 
-spec table(Expr) -> no_return() when
      Expr :: [term()].

table(Expr) ->
    %%
    %% Evaluate the expression 
    %% (Lots of matching and replacing using regular expressions)
    %%
    Prefix = atom_to_list(?MODULE) ++ ":",
    Return = [global, {return, list}],
    ExprEval = fun(A,B) ->
		       %%
		       %% "and" expression 
		       %% (Complex rules so we don't clash with "nand")
		       %%
                       CleanExpr1A = re:replace(Expr, 
						"^and", 
						Prefix ++ "b_and", Return),
		       CleanExpr1B = re:replace(CleanExpr1A, 
						" and", 
						" " ++ Prefix ++ "b_and", Return),
		       CleanExpr1C = re:replace(CleanExpr1B, 
						",and", 
						"," ++ Prefix ++ "b_and", Return),
		       CleanExpr1D = re:replace(CleanExpr1C, 
						"[(]and", 
						"(" ++ Prefix ++ "b_and", Return),
		       CleanExpr1E = re:replace(CleanExpr1D, 
						"[)]and", 
						")" ++ Prefix ++ "b_and", Return),
		   
		       %%
                       %% "or" expression 
		       %% (Complex rules so we don't clash with "nor")
		       %%
                       CleanExpr2A = re:replace(CleanExpr1E, 
						"^or", 
						Prefix ++ "b_or", Return),
                       CleanExpr2B = re:replace(CleanExpr2A, 
						" or", 
						" " ++ Prefix ++ "b_or", Return),
                       CleanExpr2C = re:replace(CleanExpr2B, 
						",or", 
						"," ++ Prefix ++ "b_or", Return),    
		       CleanExpr2D = re:replace(CleanExpr2C, 
						"[(]or", 
						"(" ++ Prefix ++ "b_or", Return),
		       CleanExpr2E = re:replace(CleanExpr2D, 
						"[)]or", 
						")" ++ Prefix ++ "b_or", Return),

		       %%
                       %% Remaining expressions 
		       %%
                       CleanExpr3 = re:replace(CleanExpr2E, 
					       "nand", 
					       Prefix ++ "n_and", Return),
                       CleanExpr4 = re:replace(CleanExpr3, 
					       "nor", 
					       Prefix ++ "n_or", Return),
		       CleanExpr5 = re:replace(CleanExpr4, 
					       "xor", 
					       Prefix ++ "x_or", Return),
                       CleanExpr6 = re:replace(CleanExpr5, 
					       "impl", 
					       Prefix ++ "impl", Return),
                       CleanExpr7 = re:replace(CleanExpr6, 
					       "equ", 
					       Prefix ++ "equ", Return),
		       
		       %%
                       %% Parse the cleaned expression    
		       %%
                       {ok, Tokens, _} = erl_scan:string(CleanExpr7),
                       {ok, Parsed} = erl_parse:parse_exprs(Tokens),
                       Bindings1 = erl_eval:add_binding('A', A, erl_eval:new_bindings()),
                       Bindings2 = erl_eval:add_binding('B', B, Bindings1),
                       {value, Value, _} = erl_eval:exprs(Parsed, Bindings2),
                       Value
	       end,

    %% Print out the results  
    Print = fun(A,B) ->
                    io:format(" ~-8w ~-8w ~-8w~n", [A, B, ExprEval(A,B)])
            end,

    %% Run through all possible combinations      
    io:format("~nExpression: ~p~n~n", [Expr]),
    Print(true, true),
    Print(true, false),
    Print(false, true),
    Print(false, false),
    io:format("~n").

%% ==============================================================================
%% @doc
%% P47 (*) Truth table for logical expressions (II).
%%
%% Continue problem P46 by defining and/2, or/2, etc as being operators. This 
%% allows us to write the logical expression in the more natural way, as in the
%% the example: A and (A or not B). Define operator precedence as usual, i.e., 
%% as in Java.
%% @end
%%
%% Example:
%% > table(A,B, A and (A or not B))
%%  
%%  true true true
%%  true fail true
%%  fail true fail
%%  fail fail fail
%% ==============================================================================

%% To support the use cases above, we need a unary boolean "not" operator
-spec b_not(A) -> B when A::boolean(), B::boolean().
			  
b_not(true) -> false;
b_not(false) -> true.

%%
%% The following helper functions and data structures are required 
%% to support P47 and P48:
%%
    
%% List of boolean operators, sorted in order of precedence:
-spec logic_operators() -> [term()].

logic_operators() -> ['not', 'xor', 'nand', 'and', 'nor', 'or', 'impl', 'equ'].

%% Return 'true' if A is higher precedence than B
-spec is_higher_precedence_than(A,B) -> boolean() when 
      A :: atom(),
      B :: atom().

is_higher_precedence_than(A,B) ->
    %% Return the index of "item" in "List"
    IndexOf = fun(_, [], _, _) -> not_found;
		 (Item, [Item|_], Index, _) -> Index;
		 (Item, [_|T], Index, Func) -> Func(Item, T, Index+1, Func)
	      end,

    IndexA = IndexOf(A, logic_operators(), 0, IndexOf),
    IndexB = IndexOf(B, logic_operators(), 0, IndexOf),
    IndexA < IndexB.
	
%%	      
%% Pop the stack, moving the top element to the result string, 
%% until we hit the argument token.
%%
-spec pop_stack_to_token(Result, Stack, Token, Func) -> {ResultPopped, StackPopped} when
      Result :: [term()],
      Stack :: [term()],
      Token :: term(),
      Func :: fun(),
      ResultPopped :: [term()],
      StackPopped :: [term()].

pop_stack_to_token(Result, [], _Token, _Func) ->
    {Result, []};
pop_stack_to_token(Result, [H|T], Token, Func) ->
    case H of
	Token ->
	    {Result, T};
	_ ->
	    Func(lists:append(Result, [H]), T, Token, Func)
    end.

%% Fully pop the stack, moving the remaining elements over to the result string
-spec pop_stack_full(Result, Stack, Func) -> ResultPopped when
      Result :: [term()],
      Stack :: [term()],
      Func :: fun(),
      ResultPopped :: [term()].

pop_stack_full(Result, [], _Func) ->
    Result;
pop_stack_full(Result, [H|T], Func) ->
    Func(lists:append(Result, [H]), T, Func).

%%
%% Move down the stack, popping all operators that have the same or higher precedence
%% than the argument token. Stop when we hit an operator that is of lower precedence.
%%
-spec pop_stack_with_token(Result, Stack, Token, Func) -> {ResultPopped, StackPopped} when
      Result :: [term()],
      Stack :: [term()],
      Token :: term(),
      Func :: fun(),
      ResultPopped :: [term()],
      StackPopped :: [term()].

pop_stack_with_token(Result, [], Token, _Func) ->
    {Result, [Token]};
pop_stack_with_token(Result, [H|T], Token, Func) ->
    case is_higher_precedence_than(H, Token) of
	true ->
	    NewResult = lists:append(Result, [H]),
	    Func(NewResult, T, Token, Func);
	_ ->
	    NewStack = lists:append([Token], [H|T]),
	    {Result, NewStack}
    end.

%%
%% Function is invoked with:
%%  (1) Tokens;
%%  (2) Result string (in post-fix order);
%%  (3) Stack (for operators);
%%  (4) Function (for recursion);
%%
-spec post_fix(Tokens, Result, Stack, Func) -> PostFixResult when
      Tokens :: [term()],
      Result :: [term()],
      Stack :: [term()],
      Func :: fun(),
      PostFixResult :: [term()].

post_fix([], Result, [], _Func) ->
    Result;
post_fix([], Result, Stack, _Func) ->
    pop_stack_full(Result, Stack, fun pop_stack_full/3);
post_fix([H|T], Result, Stack, Func) ->
    case element(1,H) of
	var ->
	    NewResult = lists:append(Result, [element(3,H)]),
	    Func(T, NewResult, Stack, Func);
	'(' ->
	    NewStack = lists:append(['('], Stack),
	    Func(T, Result, NewStack, Func);
	')' ->
	    {NewResult, NewStack} = pop_stack_to_token(Result, Stack, '(', fun pop_stack_to_token/4),
	    Func(T, NewResult, NewStack, Func);
	'and' ->
	    {NewResult, NewStack} = pop_stack_with_token(Result, Stack, 'and', fun pop_stack_with_token/4),
	    Func(T, NewResult, NewStack, Func);
	'or' ->
	    {NewResult, NewStack} = pop_stack_with_token(Result, Stack, 'or', fun pop_stack_with_token/4),
	    Func(T, NewResult, NewStack, Func);
	'xor' ->
	    {NewResult, NewStack} = pop_stack_with_token(Result, Stack, 'xor', fun pop_stack_with_token/4),
	    Func(T, NewResult, NewStack, Func);
	'not' ->
	    {NewResult, NewStack} = pop_stack_with_token(Result, Stack, 'not', fun pop_stack_with_token/4),
	    Func(T, NewResult, NewStack, Func);
	atom ->
	    case element(3,H) of
		nand ->
		    {NewResult, NewStack} = pop_stack_with_token(Result, Stack, 'nand', fun pop_stack_with_token/4),
		    Func(T, NewResult, NewStack, Func);
		nor ->
		    {NewResult, NewStack} = pop_stack_with_token(Result, Stack, 'nor', fun pop_stack_with_token/4),
		    Func(T, NewResult, NewStack, Func);
		impl ->
		    {NewResult, NewStack} = pop_stack_with_token(Result, Stack, 'impl', fun pop_stack_with_token/4),
		    Func(T, NewResult, NewStack, Func);
		equ ->
		    {NewResult, NewStack} = pop_stack_with_token(Result, Stack, 'equ', fun pop_stack_with_token/4),
		    Func(T, NewResult, NewStack, Func)
	    end;
	_ ->
	    io:format("Error parsing tokens: ~p~n", [[H|T]])
    end.

%% Return a list of parsed tokens, arranged in post-fix order
-spec parse(Expr) -> Tokens when
      Expr :: [term()],
      Tokens :: [term()].

parse(Expr) ->
    {ok, Tokens, _} = erl_scan:string(Expr),
    post_fix(Tokens, [], [], fun post_fix/4).

%% Apply the variable bindings to the expression
-spec logic_apply(Tokens, Stack, Env, Func) -> boolean() when
      Tokens :: [term()],
      Stack :: [term()],
      Env :: {term()},
      Func :: fun().

logic_apply([], [Value], _Env, _Func) ->
    Value;
logic_apply(['and'|T], [N1,N2|Stack], Env, Func) ->
    Func(T, [b_and(N1,N2)|Stack], Env, Func);
logic_apply(['or'|T], [N1,N2|Stack], Env, Func) ->
    Func(T, [b_or(N1,N2)|Stack], Env, Func);
logic_apply(['nand'|T], [N1,N2|Stack], Env, Func) ->
    Func(T, [n_and(N1,N2)|Stack], Env, Func);
logic_apply(['nor'|T], [N1,N2|Stack], Env, Func) ->
    Func(T, [n_or(N1,N2)|Stack], Env, Func);
logic_apply(['xor'|T], [N1,N2|Stack], Env, Func) ->
    Func(T, [x_or(N1,N2)|Stack], Env, Func);
logic_apply(['impl'|T], [N1,N2|Stack], Env, Func) ->
    Func(T, [impl(N1,N2)|Stack], Env, Func);
logic_apply(['equ'|T], [N1,N2|Stack], Env, Func) ->
    Func(T, [equ(N1,N2)|Stack], Env, Func);
logic_apply(['not'|T], [N1|Stack], Env, Func) ->
    Func(T, [b_not(N1)|Stack], Env, Func);
logic_apply([Sym|T], Stack, Env, Func) ->
    {ok, Val} = orddict:find(Sym, Env),
    Func(T, [Val|Stack], Env, Func);
logic_apply(_, _Stack, _Env, _Func) ->
    error.

%%
%% Example Usage: A = 'A'. B = 'B'. p99:table(A, B, "A and B").
%%
-spec table1(A, B, Expr) -> no_return() when
      A :: term(),
      B :: term(),
      Expr :: [term()].

table1(Sym1, Sym2, Expr) ->    

    %% Evaluate the expression by binding the argument variables
    Evaluate = fun(Val1, Val2) ->
		       %% Bind key-value pairs to the environment
		       Env0 = orddict:new(),
		       Env1 = orddict:store(Sym1, Val1, Env0),
		       Env2 = orddict:store(Sym2, Val2, Env1),

		       %% Parse tokens into post-fix order
		       Tokens = parse(Expr),

		       %% Apply bindings so we can evaluate expression
		       logic_apply(Tokens, [], Env2, fun logic_apply/4)
	       end,

    %% Print out the results
    Print = fun(A,B) ->
		    io:format(" ~-8w ~-8s ~-8s~n", [A, B, Evaluate(A,B)])
	    end,

    io:format("~nExpression: ~p~n~n", [Expr]),
    io:format(" ~-8s ~-8s ~-32s~n", [atom_to_list(Sym1), atom_to_list(Sym2), Expr]),
    Print(true, true),
    Print(true, false),
    Print(false, true),
    Print(false, false),
    io:format("~n").

%% =============================================================================
%% @doc
%% P48 (**) Truth tables for logical expressions (III).
%%
%% Generalize problem P47 in such a way that the logical expression may contain 
%% any number of logical variables. Define table/2 in a way that 
%% table(List,Expr) prints the truth table for the expression Expr, which 
%% contains the logical variables enumerated in List. 
%% @end
%%
%% Example:
%% > table([A,B,C], A and (B or C) equ A and B or A and C).
%% 
%%  true true true true
%%  true true fail true
%%  true fail true true
%%  true fail fail true
%%  fail true true true
%%  fail true fail true
%%  fail fail true true
%%  fail fail fail true
%% =============================================================================

%% 
%% Example Usage:
%%
%%  A = 'A'.
%%  B = 'B'.
%%  C = 'C'.
%%  L = [A,B,C].
%%  Expr = "A and (B or C)".
%%  p99:table2(L, Expr).
%%
-spec table2(List, Expr) -> no_return() when
      List :: [term()],
      Expr :: [term()].

table2(List, Expr) ->
    Evaluate = fun(Data) ->
		       %% Iteratively generate the variable bindings
		       EnvIter = fun(Env, N, N, _Func) ->
					      orddict:store(lists:nth(N, List), lists:nth(N, Data), Env);
					 (Env, N, Length, Func) ->
					      EnvNew = orddict:store(lists:nth(N, List), lists:nth(N, Data), Env),
					      Func(EnvNew, N+1, Length, Func)
				      end,
		       Env = EnvIter(orddict:new(), 1, length(Data), EnvIter),
		       
		       %% Parse tokens into post-fix order
		       Tokens = parse(Expr),
		       
		       %% Apply bindings so we can evaluate expression
		       logic_apply(Tokens, [], Env, fun logic_apply/4)
	       end,

    %% Print and process the list of truth symbols
    PrintList = fun(Data, N, N, _Func) ->
			Value = Evaluate(Data),
			io:format("~-8s ~-8s~n", [lists:nth(N, Data), Value]);
		   (Data, N, Length, Func) ->
			io:format("~-8s ", [lists:nth(N, Data)]),
			Func(Data, N+1, Length, Func)
		end,
    
    %% Generate all the true/false combinations of length N
    Combinations = fun(0, Acc, _Func) ->
			   PrintList(Acc, 1, length(Acc), PrintList);
		      (N, Acc, Func) ->
			   NewAcc1 = lists:append(Acc,[true]),   
			   Func(N-1, NewAcc1, Func),
			   NewAcc0 = lists:append(Acc,[false]),
			   Func(N-1, NewAcc0, Func)
		   end,
    
    %% Print the header for the logic table
    PrintHeader = fun([], _Func) ->
			  io:format("~-32s~n", [Expr]);
		     ([H|T], Func) ->
			  io:format("~-8s ", [H]),
			  Func(T, Func)
		  end,

    io:format("~nExpression: ~p~n~n", [Expr]),
    PrintHeader(List, PrintHeader),
    Combinations(length(List), [], Combinations).

%% ============================================================================
%% @doc
%% P49 (**) Gray code.
%% @end
%%
%% An n-bit Gray code is a sequence of n-bit strings constructed according to
%% certain rules. For example,
%%
%%  n = 1: C(1) = ['0','1'].
%%  n = 2: C(2) = ['00','01','11','10'].
%%  n = 3: C(3) = ['000','001','011','010','110','111','101','100'].
%%
%% Find out the construction rules and write a procedure with the following 
%% specification:
%%
%% > gray(N,C) :- C is the N-bit Gray code.
%%
%% Can you apply the method of "result caching" in order to make the predicate 
%% more efficient, when it is to be used repeatedly?
%% ============================================================================
%%
%% A Gray code is a sequence of binary digits such that the maximal state 
%% change between any two successive numbers is at most 1 bit. To an imperative 
%% programmer, Gray codes can be programmed relatively easily using logical XOR 
%% and register bit-shifting (and indeed, that's probably why this problem is 
%% in the "logic" section). 
%%
%% For example, the following is a simple snippet of python code that will 
%% generate the sequence of n-bit Gray codes:
%%
%%  n = 1 << input()
%%  for x in range(n):  print bin(n + x^(x/2))[3:]
%%
%% We give several examples of how to implement Gray codes in Erlang below. 
%%
%% The first example, "gray_imp", is based on the same XOR-ing idea discussed 
%% above. To see how it works, let's enumerate all the 3-bit numbers both in 
%% "binary" and in "Gray code":
%%
%%    Decimal      Binary      Gray Code
%%    -------      ------      --------- 
%%       0          000          000 (0)
%%       1          001          001 (1)
%%       2          010          011 (3)
%%       3          011          010 (2)
%%       4          100          110 (6)
%%       5          101          111 (7)
%%       6          110          101 (5)
%%       7          111          100 (4)
%%
%% In other words, even though the 0th Gray code is 0, and the 1st Gray code is
%% 1, the 2nd Gray code is actually 3 while the 3rd Gray code is 2(!). 
%%
%% It turns out that the algorithm for converting from a "normal" number to its 
%% corresponding Gray code is quite straightfoward: the n-th Gray code is given 
%% by  n ^ ( n >> 1 ); that is, (i) first shift N to the right by 1 bit; and 
%% (ii) XOR this value with the original value of N.
%%
%% Some examples might help illustrate the idea: 1 right-shifted by 1 bit is 0, 
%% which XOR-ed with 1 is still 1, so the 1st Gray code is also 1. However, 2 
%% right-shifted by 1 bit is 1, and 1 XOR-ed with 2 is 3. Hence, the 2nd Gray 
%% code is the number 3. Similarly, 3 right-shifted by 1 bit is 1, and 1 XOR-ed 
%% with 3 is 2. Hence, the 3rd Gray code is the number 2, all of which are 
%% indicated in the table above.
%%
%% In the procedure below, the bulk of the work is in just that code: 
%% (X bxor (X bsr 1)); this function is mapped over the range of the cycles, 
%% which - to generate the space of all N-bit Gray codes - is given by 
%% bit-shifting 1 to the left by N slots. The rest of the code below is 
%% concerned mainly with "prettying up" the code, to get it in the format 
%% the problem requests. 
%%
%% An excellent review of Gray codes is given by Knuth in TAOCP, Section 7.2, 
%% "Generating All Possibilities".
%% 
-spec gray_imp(N) -> List when
      N :: non_neg_integer(),
      List :: [atom()].

gray_imp(0) -> ['0'];
gray_imp(N) when is_integer(N), N > 0 ->
    Dec2Bin  = fun(X) ->
	           A = io_lib:format("~.2B~n",[X]),
		   B = lists:nth(1,A),
		   padlist(N, B)
	       end,
    Bin2Gray = fun(X) -> Dec2Bin(X bxor (X bsr 1)) end,
    Cycle    = lists:seq(0, (1 bsl N)-1),
    lists:map(Bin2Gray, Cycle).

%%
%% It would be more stylish to implement "padlist" something more like:
%%
%%  padlist(N, Acc) when length(Acc) < N ->
%%      padlist(N, "0" ++ Acc);
%%  padlist(N, Acc) when length(Acc) =:= N ->
%%      list_to_atom(Acc).
%%
%% But since we are not importing the BIF "length", we can't use it in the guard.
%%
-spec padlist(N, List) -> Atom when 
      N :: non_neg_integer(),
      List :: [term()],
      Atom :: atom().

padlist(N, Acc) when is_integer(N), is_list(Acc) ->
    case length(Acc) of
        N -> list_to_atom(Acc);
	_ -> padlist(N, "0" ++ Acc)
    end.

%%
%% Functional programmers are more likely to think of Gray's codes in terms of 
%% recursive lists. The following is a non-tail-recursive implementation that 
%% generates the sequence of n-bit Gray codes. It's likely not the most efficient
%% possible, owing to the extensive manipulation of atoms (and the general Erlang 
%% admonition to not create atoms indiscriminately. Quoting from the Erlang 
%% documentation: "an atom refers into an atom table which also consumes memory.
%% The atom text is stored once for each unique atom in this table. The atom table 
%% is NOT garbage collected").
%%
-spec gray_no_tail(N) -> List when
      N :: non_neg_integer(),
      List :: [atom()].

gray_no_tail(0) -> ['0'];
gray_no_tail(1) -> ['0', '1'];
gray_no_tail(N) when is_integer(N), N > 1 -> 
    Prepend1 = fun(X) -> list_to_atom("0" ++ atom_to_list(X)) end,
    Prepend2 = fun(X) -> list_to_atom("1" ++ atom_to_list(X)) end,
    PrevGray = gray_no_tail(N-1),
    lists:map(Prepend1,PrevGray) ++ lists:reverse(lists:map(Prepend2, PrevGray)).

%%
%% The following is a tail-recursive procedure for generating Gray's code:
%%
-spec gray(N) -> List when 
      N :: non_neg_integer(),
      List :: [atom()].

gray(N) when is_integer(N), N >= 0 -> 
    gray(N, 0, []).
gray(0, 0, _) -> ['0'];                 
gray(1, 0, _) -> ['0', '1'];            
gray(N, K, Acc) when is_integer(N), is_integer(K), is_list(Acc), K =:= (N+1) -> 
    Acc;                                 
gray(N, 0, _) when is_integer(N) -> 
    gray(N, 1, ['0']);
gray(N, 1, Acc) when is_integer(N), is_list(Acc) -> 
    gray(N, 2, lists:append(Acc, ['1']));
gray(N, K, Acc) when is_integer(N), is_integer(K), is_list(Acc) -> 
    Prepend1 = fun(X) -> list_to_atom("0" ++ atom_to_list(X)) end,
    Prepend2 = fun(X) -> list_to_atom("1" ++ atom_to_list(X)) end,
    gray(N, 
	 K+1, 
	 lists:map(Prepend1, Acc) ++ lists:reverse(lists:map(Prepend2, Acc))).

%% ==============================================================================
%% @doc
%% P50 (***) Huffman code.
%%
%% First of all, consult a good book on discrete mathematics or algorithms for a 
%% detailed description of Huffman codes!
%%
%% We suppose a set of symbols with their frequencies, given as a list of fr(S,F) 
%% terms. Example: [fr(A,45), fd(b,13), fr(c,12), fr(d,16), fr(e,9), fr(f,5)]. 
%% Our objective is to construct a list hc(S,C) terms, where C is the Huffman 
%% code word for the symbol S. In our example, the result could be Hs = 
%% [hc(a,'0'), hc(b,'101'), hc(c,'100'), hc(d,'111'), hc(e,'1101'), gc(f,'1100')].
%% @end
%%
%% The task shall be performed by the predicate huffman/2 defined as follows:
%%  
%%  > huffman(Fs,Hs) := Hs is the Huffman code table for the frequency table Fs
%% ==============================================================================
%%
%% We will take a basic "list of lists" as our data structure for the frequency 
%% table, for instance:
%%
%%   [[a, 45], [b,13], [c,12], [d,16], [e,9], [f,5]]
%%
%% We'll follow the development given in SICP 2.3 on Huffman trees.
%%

%% 
%% First let's define some procedures for generating the leaves of the tree:
%%

%% make_leaf(a,10) -> [leaf,a,10]
-spec make_leaf(Symbol, Weight) -> List when
      Symbol :: atom(),
      Weight :: non_neg_integer(),
      List :: [term()].

make_leaf(Symbol, Weight) ->
    [leaf, Symbol, Weight].

%% symbol_leaf([leaf,a,10]) -> a
-spec symbol_leaf(Leaf) -> Symbol when
      Leaf :: [term()],
      Symbol :: atom().

symbol_leaf(Leaf) when is_list(Leaf) ->
    lists:nth(2, Leaf).

%% weight_leaf([leaf,a,10]) -> 10
-spec weight_leaf(Leaf) -> Weight when
      Leaf :: [term()],
      Weight :: non_neg_integer().

weight_leaf(Leaf) when is_list(Leaf) ->
    lists:nth(3, Leaf).

%% is_leaf([leaf,a,10]) -> true
%% is_leaf([a,b,c,d]) -> false
-spec is_leaf(Leaf) -> boolean() when 
      Leaf :: [term()].

is_leaf([H|_]) when H =:= leaf -> 
    true;
is_leaf(_) -> 
    false.    

%% 
%% Procedures for constructing and manipulating the Huffman tree:
%%

% make_code_tree([leaf,a,10], [leaf,b,5]) -> [[leaf,a,10],[leaf,b,5],[a,b],15]
-spec make_code_tree(Left, Right) -> Tree when
      Left :: [term()],
      Right :: [term()],
      Tree :: [term()].

make_code_tree(Left, Right) ->
    [Left, 
     Right, 
     lists:append(symbols(Left), symbols(Right)), weight(Left) + weight(Right)].

%% left_branch([[leaf,a,10],[leaf,b,5],[a,b],15]) -> [leaf,a,10]
-spec left_branch(Tree) -> Branch when 
      Tree :: [term()],
      Branch :: [term()].

left_branch(Tree) when is_list(Tree) ->
    lists:nth(1, Tree).

%% right_branch([[leaf,a,10],[leaf,b,5],[a,b],15]) -> [leaf,b,5]
-spec right_branch(Tree) -> Branch when
      Tree :: [term()],
      Branch :: [term()].

right_branch(Tree) when is_list(Tree) ->
    lists:nth(2, Tree).

%% symbols([[leaf,a,10],[leaf,b,5]]) -> [a,b]
-spec symbols(Tree) -> Symbols when
      Tree :: [term()],
      Symbols :: [term()].

symbols(Tree) when is_list(Tree) ->
    case is_leaf(Tree) of
	true -> [symbol_leaf(Tree)];
	false -> lists:nth(3, Tree)
    end.

%% weight([[leaf,a,10],[leaf,b,5]]) -> 15
-spec weight(Tree) -> Weight when
      Tree :: [term()],
      Weight :: non_neg_integer().

weight(Tree) when is_list(Tree) ->
    case is_leaf(Tree) of
	true -> weight_leaf(Tree);
	false -> lists:nth(4, Tree)
    end.
    
%%
%% Procedures for decoding messages using a Huffman tree
%% (these are not required, but useful for testing):
%%
-spec decode(Bits, Tree) -> List when
      Bits :: [term()],
      Tree :: [term()],
      List :: [term()].

decode(Bits, Tree) ->
    Decode1 = fun([], _, _) -> 
		      [];
		 ([H|T], Current, Func) ->
		      Next = choose_branch(H, Current),
		      case is_leaf(Next) of 
			  true -> [symbol_leaf(Next)] ++ Func(T, Tree, Func);
			  false -> Func(T, Next, Func)
		      end
	      end,
    Decode1(Bits, Tree, Decode1).

-spec choose_branch(N, Tree) -> Branch when
      N :: non_neg_integer(),
      Tree :: [term()],
      Branch :: [term()].

choose_branch(0, Branch) -> 
    left_branch(Branch);
choose_branch(1, Branch) -> 
    right_branch(Branch).

%% 
%% Procedures for encoding messages using a Huffman tree:
%%
-spec encode(Symbols, Tree) -> Encoding when
      Symbols :: [term()],
      Tree :: [term()],
      Encoding :: [term()].

encode([], _) -> 
    [];
encode([H|T], Tree) -> 
    encode_symbol(H,Tree) ++ encode(T, Tree).

-spec encode_symbol(Symbol, Tree) -> Encoding when
      Symbol :: atom(),
      Tree :: [term()],
      Encoding :: [term()].

encode_symbol(Symbol, Tree) ->
    Encode2 = fun(SymbolsLeft, SymbolsRight, Left, Right, Encoded, Func) ->
		      case lists:member(Symbol, SymbolsLeft) of
			  true -> 
			      Func(Left, [0] ++ Encoded, Func);
			  false ->
			      case lists:member(Symbol, SymbolsRight) of
				  true -> 
				      Func(Right, [1] ++ Encoded, Func);
				  false -> 
				      Msg = "Bad Symbol: ENCODE-SYMBOL ~p~n",
				      io:format(Msg, [Symbol])
			      end
		      end
	      end,
    Encode1 = fun(TreeList, Encoded, Func) ->
		      case is_leaf(TreeList) of 
			  true -> lists:reverse(Encoded);
			  false ->
			      Left = left_branch(TreeList),
			      Right = right_branch(TreeList),
			      SymbolsLeft = symbols(Left),
			      SymbolsRight = symbols(Right),
			      Encode2(SymbolsLeft, 
				      SymbolsRight, 
				      Left, 
				      Right, 
				      Encoded, 
				      Func)
		      end
	      end,
    Encode1(Tree, [], Encode1).

%%
%% Procedures for generating the Huffman tree itself:
%%
-spec adjoin_set(X, Set) -> Set when
      X :: [term()],
      Set :: [term()].
      
adjoin_set(X, []) ->
    [X];
adjoin_set(X, [H|T] = L) ->
    case weight(X) < weight(H) of
	true -> [X] ++ L;
	false -> [H] ++ adjoin_set(X,T)
    end.

-spec make_leaf_set(List) -> List when 
      List :: [term()].

make_leaf_set([]) ->    
    [];
make_leaf_set([H|T]) -> 
    adjoin_set( make_leaf(lists:nth(1,H), lists:nth(2,H)), make_leaf_set(T) ).

%% Could implement this with a guard, but we're not importing the BIF length/1:
-spec successive_merge(Pairs) -> Tree when 
      Pairs :: [term()],
      Tree :: [term()].

successive_merge([H|_] = Pairs) when is_list(Pairs) ->
    case length(Pairs) of
	1 -> H;
	_ ->
	    First = lists:nth(1, Pairs),
	    Second = lists:nth(2, Pairs),
	    Rest = lists:sublist(Pairs, 3, length(Pairs)),
	    successive_merge(adjoin_set(make_code_tree(First, Second), Rest))
    end.

-spec generate_huffman_tree(Pairs) -> Tree when 
      Pairs :: [term()],
      Tree :: [term()].

generate_huffman_tree(Pairs) ->
    successive_merge(make_leaf_set(Pairs)).

%%
%% Finally, the procedure we are asked to implement.
%%
%% For instance, if we run the sample given in the problem statement with:
%%
%%  > Pairs = [[a,45],[b,13],[c,12],[d,16],[e,9],[f,5]].
%%  > huffman(Pairs) 
%%  > [[a,'0'],[b,'101'],[c,'100'],[d,'111'],[e,'1101'],[f,'1100']]
%%
%% which is the answer given in the problem statement.
%%
-spec huffman(Pairs) -> Tree when
      Pairs :: [term()],
      Tree :: [term()].

huffman(Pairs) ->
    Tree = generate_huffman_tree(Pairs),
    Mapper = fun([H|_]) ->
		     Tree = generate_huffman_tree(Pairs),
		     Encoding = encode_symbol(H, Tree),
		     [H, list_to_atom(lists:concat(Encoding))]
	     end,
    lists:map(Mapper, Pairs).		      

%%
%% =========================
%%  PART IV -- BINARY TREES
%% =========================
%%

%% ========================================================================
%% @doc
%% P54A (*) Check whether a given term represents a binary tree.
%%
%% Write a predicate istree which returns true if and only if its argument 
%% is a list representing a binary tree.
%% @end
%% 
%% Example:
%% > (istree (a (b nil nil) nil))
%% > true
%%
%% > (istree (a (b nil nil)))
%% > false
%% ========================================================================
%%
%% First define some "helper" methods that return binary trees so we can test.
%%
%% The following three procedures are constructors for building binary trees:
%%
-spec make_binary_tree() -> Tree when 
      Tree :: term() | [term()].

make_binary_tree() -> nil.

-spec make_binary_tree(Root) -> Tree when 
      Tree :: term() | [term()], 
      Root :: term() | [term()].

make_binary_tree(Root) ->
    make_binary_tree(Root, make_binary_tree(), make_binary_tree()).

-spec make_binary_tree(Root, Left, Right) -> Tree when 
      Tree :: term() | [term()],				   
      Root :: term() | [term()],
      Left :: term() | [term()],
      Right :: term() | [term()].

make_binary_tree(Root, Left, Right) ->
    [Root, Left, Right].

%%
%% Procedure for generating "sample" trees. 
%%
-spec make_sample_tree(N) -> Tree when 
      N :: pos_integer(),
      Tree :: term() | [term()].

make_sample_tree(1) -> make_binary_tree();
make_sample_tree(2) -> make_binary_tree(a);
make_sample_tree(3) -> 
    NodeD = make_binary_tree(d),
    NodeE = make_binary_tree(e),
    NodeB = make_binary_tree(b, NodeD, NodeE),
    NodeG = make_binary_tree(g),
    NodeF = make_binary_tree(f, NodeG, make_binary_tree()),
    NodeC = make_binary_tree(c, make_binary_tree(), NodeF),
    NodeA = make_binary_tree(a, NodeB, NodeC),
    NodeA;
make_sample_tree(4) -> 
    NodeB = make_binary_tree(b),
    NodeA = make_binary_tree(a, NodeB, make_binary_tree()),
    NodeA;
make_sample_tree(5) ->
    NodeD = make_binary_tree(d),
    NodeG = make_binary_tree(g),
    NodeE = make_binary_tree(e, NodeD, NodeG),
    NodeA = make_binary_tree(a),
    NodeC = make_binary_tree(c, NodeA, NodeE),
    NodeM = make_binary_tree(m),
    NodeK = make_binary_tree(k, NodeC, NodeM),
    NodeQ = make_binary_tree(q),
    NodeP = make_binary_tree(p, make_binary_tree(), NodeQ),
    NodeU = make_binary_tree(u, NodeP, make_binary_tree()),
    NodeN = make_binary_tree(n, NodeK, NodeU),
    NodeN;
make_sample_tree(6) ->
    NodeA = make_binary_tree(a),
    NodeB = make_binary_tree(b),
    NodeC = make_binary_tree(c),
    NodeD = make_binary_tree(d),
    NodeE = make_binary_tree(e),
    NodeF = make_binary_tree(f),
    NodeG = make_binary_tree(g),
    NodeH = make_binary_tree(h),
    NodeI = make_binary_tree(i, NodeA, NodeB),
    NodeJ = make_binary_tree(j, NodeC, NodeD),
    NodeK = make_binary_tree(k, NodeE, NodeF),
    NodeL = make_binary_tree(l, NodeG, NodeH),
    NodeM = make_binary_tree(m, NodeI, NodeJ),
    NodeN = make_binary_tree(n, NodeK, NodeL),
    NodeO = make_binary_tree(o, NodeM, NodeN),
    NodeO;
make_sample_tree(7) ->
    NodeA = make_binary_tree(a),
    NodeC = make_binary_tree(c),
    NodeE = make_binary_tree(e),
    NodeD = make_binary_tree(d, NodeC, NodeE),
    NodeB = make_binary_tree(b, NodeA, NodeD),
    NodeH = make_binary_tree(h),
    NodeI = make_binary_tree(i, NodeH, make_binary_tree()),
    NodeG = make_binary_tree(g, make_binary_tree(), NodeI),
    NodeF = make_binary_tree(f, NodeB, NodeG),
    NodeF;
make_sample_tree(8) ->
    NodeD = make_binary_tree(d),
    NodeC = make_binary_tree(c, NodeD, make_binary_tree()),
    NodeB = make_binary_tree(b, NodeC, make_binary_tree()),
    NodeA = make_binary_tree(a, NodeB, make_binary_tree()),
    NodeA;
make_sample_tree(9) ->
    NodeD = make_binary_tree(d),
    NodeC = make_binary_tree(c, make_binary_tree(), NodeD),
    NodeB = make_binary_tree(b, make_binary_tree(), NodeC),
    NodeA = make_binary_tree(a, make_binary_tree(), NodeB),
    NodeA;
make_sample_tree(10) ->
    NodeA1 = make_binary_tree(a),
    NodeB = make_binary_tree(b),
    NodeA2 = make_binary_tree(a, NodeB, NodeA1),
    NodeA2;
make_sample_tree(11) ->
    NodeB = make_binary_tree(b),
    NodeA1 = make_binary_tree(a, make_binary_tree(), NodeB),
    NodeA2 = make_binary_tree(a, make_binary_tree(), NodeA1),
    NodeA2;
make_sample_tree(12) ->
    NodeB = make_binary_tree(b),
    NodeA1 = make_binary_tree(a),
    NodeA2 = make_binary_tree(a, NodeA1, NodeB),
    NodeA2.

-spec make_sample_tree_fake(N) -> Tree when
      N :: pos_integer(),
      Tree :: term() | [term()].

make_sample_tree_fake(1) -> 
    [a, [b, nil, nil]].

%%
%% Finally, the definition of the is_tree procedure:
%%
-spec is_tree(A) -> boolean() when 
      A :: term() | [term()].

is_tree(nil) -> true;
is_tree([_Root, nil, nil]) -> true;
is_tree([_, Left, Right]) ->
    Val1 = is_tree(Left),
    Val2 = is_tree(Right),
    case {Val1, Val2} of
	{true, true} -> true;
	_ -> false
    end;
is_tree(_) -> false.

%% =============================================================================
%% @doc
%% P55 (**) Construct completely balanced binary trees
%% 
%% In a completely balanced binary tree, the following property holds for every
%% node: The number of nodes in its left subtree and the number of nodes in its
%% right subtree are almost equal, which means their difference is not greater
%% than one.
%%
%% Write a function cbal-tree to construct completely balanced binary trees for 
%% a given number of nodes. The predicate sbhould generate all solutions via
%% backtracking. Put the letter 'x' as information into all nodes of the tree.
%% @end
%%
%% Example:
%% > cbal-tree(4,T)
%% > T = t(x, t(x, nil, nil), t(x, nil, t(x, nil, nil)))
%% > T = t(x, t(x, nil, nil), t(x, t(x, nil, nil) nil)))
%% =============================================================================
%%
%% A balanced binary tree with four nodes comes in 4 permutations:
%%
%%  Permutation 1
%%  ------------- 
%%      x
%%     / \ 
%%    x   x
%%         \ 
%%          x
%%
%%  Permutation 2
%%  ------------- 
%%      x
%%     / \
%%    x   x
%%       /
%%      x 
%%
%%  Permutation 3
%%  ------------- 
%%      x
%%     / \
%%    x   x
%%     \   
%%      x
%%
%%  Permutation 4
%%  ------------- 
%%      x 
%%     / \
%%    x   x
%%   /     
%%  x  
%%

%% 
%% Suppose we wish to construct a balanced tree of height h. We could 
%% accomplish this by starting with a root node 'x', and adding a balanced
%% tree of height h-1 as the left branch, and a second balanced tree of 
%% height h-1 as the right branch.
%%
%% This is the general heueristic we follow below.
%%
%% Note that a balanced tree of height h will have (roughly) twice as 
%% many nodes as a balanced tree of height h-1.
%%
%% Note too that we must include in our result set all possible combinations
%% of balanced trees of height h-1 on the left branch with all possible
%% combinations of balanced trees of height h-1 on the right branch.
%%
-spec cbal_tree(N) -> List when 
      N :: non_neg_integer(),
      List :: [term()].

cbal_tree(0) ->
    [nil];
cbal_tree(N) when N rem 2 =:= 1, N > 0 -> 
    %% Branch when N is odd
    Arg1 = round((N-1)/2),
    cartesian_process(cbal_tree(Arg1), cbal_tree(Arg1));
cbal_tree(N) when N rem 2 =:= 0, N > 0 ->
    %% Branch when N is even
    Arg1 = round((N-2)/2),
    Arg2 = round(N/2),
    cartesian_process(cbal_tree(Arg1), cbal_tree(Arg2)) ++
	cartesian_process(cbal_tree(Arg2), cbal_tree(Arg1)).
	
process(List) when is_list(List) ->
    lists:map(fun(X) -> [x] ++ X end, List).

cartesian_product(List1, List2) when is_list(List1), is_list(List2) ->
    [[X,Y] || X <- List1,
	      Y <- List2].
	       
cartesian_process(List1, List2) when is_list(List1), is_list(List2) ->
    process(cartesian_product(List1, List2)).

%% =============================================================================
%% @doc
%% P56 (**) Symmetric binary trees
%%
%% Let us call a binary tree symmetric if you can draw a vertical line through 
%% the root node and then the right subtree is the mirror image of the left
%% subtree. Write a function 'symmetric' to check whether a given binary tree
%% is symmetric. We are only interested in the structure, not in the contents
%% of the nodes.
%% @end
%% =============================================================================
-spec symmetric(Tree) -> boolean() when
      Tree :: term() | [term()].

symmetric(nil) ->
    true;
symmetric([_Root, nil, nil]) ->
    true;
symmetric([_Root, Left, Right]) ->
    equal_structure(Left, revert(Right)).

revert([]) ->
    [];
revert(nil) ->
    nil;
revert([Root, Left, Right]) ->
    make_binary_tree(Root, revert(Right), revert(Left)).

equal_structure([], []) ->
    true;
equal_structure(nil, nil) ->
    true;
equal_structure(_Tree, []) ->
    false;
equal_structure(_Tree, nil) ->
    false;
equal_structure([], _Tree) ->
    false;
equal_structure(nil, _Tree) ->
    false;
equal_structure([_Root1, Left1, Right1], [_Root2, Left2, Right2]) ->
    equal_structure(Left1, Left2) and equal_structure(Right1, Right2).
    
%% ===========================================================================
%% @doc
%% P57 (**) Binary search trees (dictionaries)
%%
%% Write a function to construct a binary search tree from a list of integer
%% numbers.
%% @end
%%
%% Example:
%% > (construct '(3 2 5 7 1))
%% > (3 (2 (1 nil nil) nil) (5 nil (7 nil nil)))
%%
%% Then use this function to test the solution of P56.
%% 
%% Example:
%% > (symmetric '(5 3 18 1 4 12 21))
%% > true
%% > (symmetric '(3 2 5 7 1))
%% > true
%% > (symmetric '(3 2 5 7))
%% > false
%% ===========================================================================
-spec construct(List) -> Tree when 
      List :: [term()],
      Tree :: [term()].

construct(List) when is_list(List) ->
    construct(List,[]).

construct([], Tree) ->
    Tree;
construct([H|T], Tree) ->
    construct(T, best_add(H, Tree)).

best_add(Item, []) ->
    make_binary_tree(Item);
best_add(Item, nil) ->
    make_binary_tree(Item);
best_add(Item, [Root, Left, Right]) when Item < Root ->
    make_binary_tree(Root, best_add(Item, Left), Right);
best_add(Item, [Root, Left, Right]) when Item > Root ->
    make_binary_tree(Root, Left, best_add(Item, Right));
best_add(_Item, Tree) ->
    Tree.

%% =============================================================================
%% @doc
%% P58 (**) Geneate-and-test paradigm.
%%
%% Apply the generate-and-test paradigm to construct all symmetric, completely
%% balanced binary trees with a given number of nodes.
%% @end
%% 
%% Example:
%%
%% > (sym-cbal-trees-print 5)
%% (x (x nil (x nil nil)) (x (x nil nil) nil))
%% (x (x (x nil nil) nil) (x nil (x nil nil)))
%%
%% How many such trees are there with 57 nodes? Investigate about how many 
%% solutions there are for a given number of nodes. What if the number is 
%% even?
%% =============================================================================
-spec sym_cbal_trees_print(N) -> any() when 
      N :: non_neg_integer().

sym_cbal_trees_print(N) when N >= 0 ->
    CBalTrees = cbal_tree(N),
    SymCBalTrees = lists:filter(fun (X) -> symmetric(X) end, CBalTrees),
    Length = length(SymCBalTrees),
    io:format("Number of Trees: ~p~n", [Length]),
    sym_cbal_trees_print_iter(SymCBalTrees).

sym_cbal_trees_print_iter([]) ->
    io:format("");
sym_cbal_trees_print_iter([H|T]) ->
    Val1 = symmetric(H),
    case Val1 of 
	true ->
	    io:format("~p~n", [H]),
	    sym_cbal_trees_print_iter(T);
	_ ->
	    sym_cbal_trees_print_iter(T)
    end.

%%
%% There are 256 symmetric, completely balanced trees with 57 nodes.
%%
%% The following is a table of the number of solutions for a given number
%% a given number of nodes:
%%
%% --------------------- 
%% | Nodes | Solutions |
%% --------------------- 
%% |   0   |     1     | 
%% |   1   |     1     |
%% |   2   |     0     |
%% |   3   |     1     |
%% |   4   |     0     |
%% |   5   |     2     |
%% |   6   |     0     |
%% |   7   |     1     |
%% |   8   |     0     |
%% |   9   |     4     |
%% |  10   |     0     |
%% ---------------------
%%
%% With the exception of N=0, there are no solutions when the number of 
%% nodes is even. 
%%
%% A general pattern can be deduced as follows: Suppose the number of nodes
%% in the tree is 2^n + 1. Then there will be 2^(n-1) solutions. This is 
%% expressed in the following table:
%%
%% -----------------------------------------
%% | Number of Nodes | Number of Solutions |
%% -----------------------------------------
%% |       5         |          2          |
%% |       9         |          4          |
%% |      17         |          8          |
%% |      33         |         16          |
%% |      65         |         32          |
%% |     129         |         64          |
%% -----------------------------------------
%%  

%% ===========================================================================
%% @doc
%% P59 (**) Construct height-balanced binary trees
%%
%% In a height-balanced binary tree, the following property holds for every
%% node: The height of its left subtree and the height of its right subtree
%% are almost equal, which means their difference is not greater than one.
%%
%% Write a fnuction 'hbal-tree' to construct height-balanced binary trees
%% for a given height. The function should generate all solutions. Put the 
%% letter 'x' as information into all nodes of the tree.
%% @end
%%
%% Example:
%% > (hbal-tree 3)
%% (X (X (X NIL NIL) (X NIL NIL)) (X (X NIL) (X NIL NIL)))
%% = (X (X (X NIL NIL) (X NIL NIL)) (X (X NIL NIL) NIL))
%% ===========================================================================
-spec hbal_tree(N) -> List when
      N :: non_neg_integer(),
      List :: [term()].

hbal_tree(0) ->
    [make_binary_tree()];
hbal_tree(1) ->
    [make_binary_tree(x)];
hbal_tree(N) when N > 1 ->
    Tree1 = hbal_tree(N-1),
    Tree2 = hbal_tree(N-2),
    cartesian_process(Tree1, Tree2) ++
	cartesian_process(Tree1, Tree1) ++
	cartesian_process(Tree2, Tree1).

%% =============================================================================
%% @doc
%% P60 (**) Construct height-balanced binary trees with a given number of nodes
%%
%% Consider a height-balanced tree of height H. What is the maximum number of 
%% nodes it can contain? Clearly, MAX N = 2**H - 1. However, what is the minimum
%% number of nodes? This question is more difficult. Try to find a recursive
%% statement and turn it into a function minnodes defined as follows:
%%
%% (min-nodes H) returns the minimum number of nodes in a height-balanced binary
%% tree of height H.
%%
%% On the other hand, we might ask: what is the maximum height of a height-
%% balanced binary tree with N nodes?
%%
%% (max-height N) returns the maximum height of a height-balanced binary tree
%% with N nodes.
%%
%% Now we can attack the main problem: construct all the height-balanced binary
%% trees with a given number of nodes.
%%
%% (hbal-tree-nodes N) returns all height-balanced binary trees with N nodes.
%%
%% Find out how many height-balanced binary trees exist for N = 15.
%% @end
%% =============================================================================

%%
%% Helper 'ceiling' function.
%% 
-spec ceiling(Float) -> Integer when
      Float :: float() | integer(),
      Integer :: integer().

ceiling(X) ->
    T = erlang:trunc(X),
    case (X-T) of
	Neg when Neg < 0 -> T;
	Pos when Pos > 0 -> T + 1;
	_ -> T
    end.

%%
%% Helper 'floor' function.
%%
-spec floor(Float) -> Integer when
      Float :: float() | integer(),
      Integer :: integer().

floor(X) ->
    T = erlang:trunc(X),
    case (X-T) of
	Neg when Neg < 0 -> T - 1;
	Pos when Pos > 0 -> T;
	_ -> T
    end.

%%
%% This procedure counts the minimum number of nodes that a height-balanced
%% tree of height H may have.
%%
-spec min_nodes(N) -> N when 
      N :: non_neg_integer().

min_nodes(0) ->
    0;
min_nodes(1) ->
    1;
min_nodes(H) when H > 1 ->
    min_nodes(H-1) + min_nodes(H-2) + 1.

%%
%% This procedure counts the maximum number of nodes that a height-balanced
%% tree of height H may have.
%%
-spec max_nodes(N) -> N when 
      N :: non_neg_integer().

max_nodes(H) when H >= 0 ->
    round(math:pow(2,H) - 1).

%%
%% This procedure returns the minimum height that a height-balanced tree with 
%% N nodes may have. (this height calculation is still wrong)
%%
-spec min_height(N) -> N when 
      N :: non_neg_integer().

min_height(N) when N >= 0 ->
    ceiling(math:log(N+1) / math:log(2)).

%%
%% Helper function for calculating 'max_height' below.
%%    
-spec node_counter(N) -> N when
      N :: non_neg_integer().

node_counter(0) ->
    0;
node_counter(1) ->
    1;
node_counter(N) when N > 1 ->
    node_counter(N-1) + node_counter(N-2) + 1.

%% 
%% This procedure returns the maximum height that a height-balanced tree with
%% N nodes may have.
%%
-spec max_height(N) -> N when
      N :: non_neg_integer().

max_height(0) ->
    0;
max_height(1) ->
    1;
max_height(N) when N > 1 ->
    max_height(N,1).

max_height(N,H) ->
    Nodes = node_counter(H),
    case Nodes of
	Less when Less < N -> max_height(N,H+1);
	Greater when Greater > N -> H-1;
	_ -> H
    end.

%%
%% This procedure counts the total number of nodes in a tree.
%%
-spec count_nodes(Tree) -> N when 
      Tree :: term() | [term()],
      N :: non_neg_integer().

count_nodes([]) ->
    0;
count_nodes(nil) ->
    0;
count_nodes([_Root, nil, nil]) ->
    1;
count_nodes([_Root, Left, Right]) ->
    count_nodes(Left) + count_nodes(Right) + 1.
    
%%
%% Finally, the actual procedure that generates the list of height-balanced
%% trees with the requisite number of Nodes. The procedure works as follows:
%%
%%  1) Determine the height of the shortest hbal tree containing 'Nodes' nodes.
%%  2) Determine the height of the tallest hbal tree containing 'Nodes' nodes.
%%  3) Build a range of heights bounded by these two values.
%%  4) Generate the list of all trees containing these heights, flatten as 
%%     needed.
%%  5) Filter the resulting list, retaining only those trees with the correct
%%     number of nodes.
%%
-spec hbal_tree_nodes(N) -> [Tree] when
      N :: non_neg_integer(),
      Tree :: term() | [term()].

hbal_tree_nodes(Nodes) when Nodes >= 0 ->
    Heights = lists:seq(min_height(Nodes), max_height(Nodes)),
    Trees = lists:map(fun p99:hbal_tree/1, Heights),
    FlatTrees = lists:foldr(fun(X, List) -> X ++ List end, [], Trees),
    lists:filter( fun(Tree) -> count_nodes(Tree) =:= Nodes end, FlatTrees).
	
%%
%% There are 1,553 height-balanced trees with 15 nodes.
%%
		   
%% ==========================================================================
%% @doc
%% P61 (*) Count the leaves of a binary tree.
%%
%% A leaf is a node with no successors.
%%
%% Write a function 'count-leaves' to count them.
%%
%% (count-leaves tree) returns the number of leaves of a binary tree 'tree'.
%% @end
%% ==========================================================================
-spec count_leaves(Tree) -> non_neg_integer() when 
      Tree :: term() | [term()].

count_leaves(nil) ->
    0;
count_leaves([_Root, nil, nil]) -> 
    1;
count_leaves([_Root, Left, Right]) -> 
    count_leaves(Left) + count_leaves(Right).

%% ========================================================================
%% @doc
%% P61A (*) Collect the leaves of a binary tree in a list.
%%
%% A leaf is a node with no successors.
%%
%% Write a function 'leaves' to return them in a list.
%%
%% (leaves tree) returns the list of all leaves of the binary tree 'tree'.
%% @end
%% ========================================================================
-spec leaves(Tree) -> List when 
      Tree :: term() | [term()],
      List :: [term()].

leaves(nil) ->
    [];
leaves([Root, nil, nil]) ->
    [Root];
leaves([_Root, Left, Right]) ->
    leaves(Left) ++ leaves(Right).

%% =============================================================================
%% @doc
%% P62 (*) Collect the internal nodes of a binary tree in a list.
%%
%% An internal node of a binary tree has either one or two non-empty successors.
%%
%% Write a function 'internals' to collect them in a list.
%%
%% (internals tree) returns the list of internal nodes of the binary tree 'tree'.
%% @end
%% ==============================================================================
-spec internals(Tree) -> List when
      Tree :: term() | [term()],
      List :: [term()].

internals(nil) ->
    [];
internals([_Root, nil, nil]) ->
    [];
internals([Root, Left, Right]) ->
    [Root] ++ internals(Left) ++ internals(Right).

%% ============================================================================
%% @doc
%% P62B (*) Collect the nodes at a given level in a list.
%%
%% A node of a binary tree is at level N if the path from the root to the node
%% has length N-1. The root node is at level 1. Write a function 'atlevel' to 
%% collect all nodes at a given level in a list.
%%
%% (atlevel tree L) return the list of nodes of the binary tree 'tree' at 
%% Level 'L'.
%%
%% Using 'atlevel' it is easy to construct a function 'levelorder' which 
%% creates the level-order sequence of the nodes. However, there are more
%% efficient ways to do that.
%% @end
%% ============================================================================
-spec at_level(Tree, pos_integer()) -> List when
      Tree :: [term()],
      List :: [term()].

at_level(nil, _Level) -> 
    [];
at_level([Root, _Left, _Right], 1) ->
    [Root];
at_level([_Root, Left, Right], Level) ->
    at_level(Left, Level-1) ++ at_level(Right, Level-1).

%% =============================================================================
%% @doc
%% P63 (**) Construct a complete binary tree.
%%
%% A complete binary tree with height H is defined as follows: the levels
%% 1,2,3,...,H-1 contain the maximum number of nodes (i.e., 2**(i-1) at the 
%% level i, note that we start counting the levels from 1 at the root). 
%% In level H, which may contain less than the maximum possible number of 
%% nodes, all the nodes are "left-adjusted". This means that in a levelorder
%% tree traversal all internal nodes come first, the leaves come second, and 
%% empty successors (the nils which are not really nodes) come last.
%%
%% Particularly, complete binary trees are used as data structures (or 
%% addressing schemes) for heaps.
%%
%% We can assign an address number to each node in a complete binary tree by
%% enumerating the nodes in levelorder, starting at the root with number 1.
%% In doing so, we realize that for every node X with address A the following 
%% property holds: The address of X's left and right successors are 2*A and 
%% 2*A + 1, respectively, suppossing that the successors do exist. This fact
%% can be used to elegantly construct binary tree structures. Write a function
%% complete-binary-tree with the following specification:
%%
%% (complete-binary-tree N) returns a complete binary tree with N nodes.
%%
%% Test your function in an appropriate way.
%% @end
%% =============================================================================
-spec complete_binary_tree(N) -> Tree when
      N :: non_neg_integer(),
      Tree :: term() | [term()].

complete_binary_tree(N) when N >= 0 ->
    cbtree_label(N, 1).

cbtree_label(0, _) ->
    make_binary_tree();
cbtree_label(1, K) ->
    make_binary_tree(K);
cbtree_label(N, K) ->
    P = floor( highest_2_power(N) / 2 ),
    P2 = floor(N/P),
    case P2 =:= 2 of
	true -> Left = P + (N rem P);
	false -> Left = 2 * P - 1
    end,
    make_binary_tree(K,
		     cbtree_label(Left, 2 * K),
		     cbtree_label(N - Left - 1, 2 * K + 1)).

%%
%% Highest power of 2 which is less than or equal to N
%%
highest_2_power(1) ->
    1;
highest_2_power(N) when N > 1 ->
    2 * highest_2_power( floor(N/2) ).

%%
%% Helper function to test whether Tree is a complete binary tree.
%%
%% Validates (i) the complete binary tree property, and (ii) whether 
%% or not the sub-branches similarly are binary trees.
%%
-spec is_complete_binary_tree(Tree) -> boolean() when
      Tree :: term() | [term()].

is_complete_binary_tree(nil) ->    
    true;
is_complete_binary_tree([_Root, nil, nil]) -> 
    true;
is_complete_binary_tree([Root, [H1|T1], nil]) ->
    (2 * Root =:= H1) and
	is_complete_binary_tree([H1|T1]);
is_complete_binary_tree([Root, [H1|T1], [H2|T2]]) ->
    (2 * Root =:= H1) and
	(2 * Root + 1 =:= H2) and
	is_complete_binary_tree([H1|T1]) and
	is_complete_binary_tree([H2|T2]).

%% =============================================================================
%% @doc
%% P64 (**) Layout a binary tree (1)
%%
%% Consider a binary tree as the usual symbolic express (X L R) or nil. As a
%% preparation for drawing the tree, a layout algorithm is required to determine
%% the position of each node in a rectangular grid. Several layout methods are 
%% conceivable, one of them is shown in the illustration below.
%%
%% In this layout strategy, the position of a node v is obtained by the following
%% two rules:
%%
%% (1) x(v) is equal to the position of the node in the inorder sequence.
%% (2) y(y) is equal to the depth of the node v in the tree.
%%
%% In order to store the position of the nodes, we extend the symbolic
%% expression representing a node (and its successor) as follows:
%%
%% (*) nil represents the empty tree (as usual)
%% (*) (W X Y L R) represents a (non-empty) binary tree with root W "positioned"
%% at (X,Y) and subtress L and R.
%%
%% Write a function layout-binary-tree with the following specification:
%%
%% (layout-binary-tree tree) returns the "positioned" binary tree obtained 
%% from the binary tree 'tree'.
%% @end
%% =============================================================================

%%
%% OK, so I read the question wrong(!)
%% 
%% What I've generated below are procedures for actually drawing the graphs, 
%% when in fact all that is requested is a procedure for alterating the data
%% structure used to represent the graph.
%%
%% The code (immediately) below is the drawing code, and the requested data
%% structure modification code follows:
%%

%%
%% Counting the nodes will give us the "width" of the graph.
%% 
%% Determining the depth of the tree will give us the "height" of the graph.
%% 
count_depth(nil) ->
    0;
count_depth([_Root, Left, Right]) ->
    LeftDepth = count_depth(Left),
    RightDepth = count_depth(Right),
    case LeftDepth > RightDepth of
	true -> LeftDepth + 1;
	false -> RightDepth + 1
    end.

-spec print_binary_tree(Tree) -> no_return() when
      Tree :: term() | [term()].

print_binary_tree(nil) ->
    io:format("");    
print_binary_tree(Tree) ->
    Width = count_nodes(Tree),
    Height = count_depth(Tree),
    TreeList = binary_tree_process_tree_by_x(Tree,1),
    io:format("+~s+~n", [string:copies("-", Width)]),
    print_binary_tree_rows(TreeList, Width, Height),
    io:format("+~s+~n", [string:copies("-", Width)]).

%%
%% Perform in-order walk on the tree.
%%
%% Return a list of the node tuples. A node tuple contains the node label 
%% at that point as well as the depth of the node. The nodes in the list
%% are sorted according to the "in-order walk" metric, so that the ordering
%% of the nodes can be used to determine the x-coordinate of the node in the 
%% graph. In turn, the "depth" of the node is used to determine the y-
%% coordinate of the node in the graph.
%%
%% For instance, consider the following binary tree:
%%
%% [a,[b,[d,nil, nil],[e, nil, nil]],[c,nil,[f,[g,nil,nil],nil]]]
%%
%% When this structure is passed to this method, it returns:
%%
%% [{d,3},{b,2},{e,3},{a,1},{c,2},{g,4},{f,3}]
%%
%% When displayed as a graph, this structure looks like:
%%
%% +-------+
%% |   a   |
%% | b  c  |
%% |d e   f|
%% |     g |
%% +-------+
%%
binary_tree_process_tree_by_x(nil, _Depth) ->
    [];
binary_tree_process_tree_by_x([Root, nil, nil], Depth) ->
    [{Root,Depth}];
binary_tree_process_tree_by_x([Root, Left, Right], Depth) ->
    binary_tree_process_tree_by_x(Left, Depth+1) ++
	[{Root,Depth}] ++
	binary_tree_process_tree_by_x(Right, Depth+1).

%%
%% Row APIs
%%
print_binary_tree_rows(TreeList, W, H) ->
    print_binary_tree_rows(TreeList, W, H, 1).

print_binary_tree_rows(Tree, W, H, H) ->
    print_binary_tree_print_row(Tree, W, 1, H);
print_binary_tree_rows(Tree, W, H, Y) when Y < H ->
    print_binary_tree_print_row(Tree, W, 1, Y),
    print_binary_tree_rows(Tree, W, H, Y+1).

print_binary_tree_print_row(Tree, W, X, Y) ->
    io:format("|"),
    print_binary_tree_cols(Tree, W, X, Y),
    io:format("|~n").

%%
%% Column and Node APIs
%%
print_binary_tree_cols(Tree, W, W, Y) ->
    print_binary_tree_print_node(Tree, W, Y);
print_binary_tree_cols(Tree, W, X, Y) when X < W ->
    print_binary_tree_print_node(Tree, X, Y),
    print_binary_tree_cols(Tree, W, X+1, Y).

print_binary_tree_print_node(Tree, X, Y) ->
    Node = lists:nth(X, Tree),
    case Node of 
	{Val, Y} -> io:format("~p", [Val]);
	_ -> io:format(" ")
    end.

%% 
%% We can test the procedure with the following structures:
%%
%% [a,nil,nil]
%%
%% +-+
%% |a|
%% +-+
%%
%% [a,[b,[d,nil,nil],[e,nil,nil]],[c,nil,[f,[g,nil,nil],nil]]]
%%
%% +-------+
%% |   a   |
%% | b  c  |
%% |d e   f|
%% |     g |
%% +-------+
%%
%% [a,[b,nil,nil],nil]
%%
%% +--+
%% | a|
%% |b |
%% +--+
%%
%% [n,
%%  [k,[c,[a,nil,nil],[e,[d,nil,nil],[g,nil,nil]]],[m,nil,nil]],
%%  [u,[p,nil,[q,nil,nil]],nil]]
%%
%% +-----------+
%% |       n   |
%% |     k    u|
%% | c    m p  |
%% |a  e     q |
%% |  d g      |
%% +-----------+
%%
%% [o,
%%  [m,[i,[a,nil,nil],[b,nil,nil]],[j,[c,nil,nil],[d,nil,nil]]],
%%  [n,[k,[e,nil,nil],[f,nil,nil]],[l,[g,nil,nil],[h,nil,nil]]]]
%%
%% +---------------+
%% |       o       |
%% |   m       n   |
%% | i   j   k   l |
%% |a b c d e f g h|
%% +---------------+
%%
%% A complete binary tree with 8 nodes:
%%
%% [1,
%%  [2,[4,[8,nil,nil],nil],[5,nil,nil]],
%%  [3,[6,nil,nil],[7,nil,nil]]]
%%
%% +--------+
%% |    1   |
%% |  2   3 |
%% | 4 5 6 7|
%% |8       |
%% +--------+
%%

%%
%% Now, to answer the original question:
%%
-spec layout_binary_tree(Tree) -> Tree when
      Tree :: term() | [term()].

layout_binary_tree(Tree) ->
    TreeList = binary_tree_process_tree_by_x(Tree,0),
    layout_binary_tree(Tree, TreeList).

layout_binary_tree([], _TreeList) ->
    [];
layout_binary_tree([Root, nil, nil], TreeList) ->
    X = layout_binary_tree_lookup_x(Root, TreeList),
    Y = layout_binary_tree_lookup_y(Root, TreeList),
    [Root, X, Y, nil, nil];
layout_binary_tree([Root, Left, nil], TreeList) ->
    X = layout_binary_tree_lookup_x(Root, TreeList),
    Y = layout_binary_tree_lookup_y(Root, TreeList),
    [Root, X, Y, layout_binary_tree(Left, TreeList), nil];
layout_binary_tree([Root, nil, Right], TreeList) ->
    X = layout_binary_tree_lookup_x(Root, TreeList),
    Y = layout_binary_tree_lookup_y(Root, TreeList),
    [Root, X, Y, nil, layout_binary_tree(Right, TreeList)];
layout_binary_tree([Root, Left, Right], TreeList) ->
    X = layout_binary_tree_lookup_x(Root, TreeList),
    Y = layout_binary_tree_lookup_y(Root, TreeList),
    [Root, X, Y, layout_binary_tree(Left, TreeList), layout_binary_tree(Right, TreeList)].

%%
%% Lookup x-coord of an atom in the list
%%
layout_binary_tree_lookup_x(Atom, List) ->
    layout_binary_tree_lookup_x(Atom, List, 1).

layout_binary_tree_lookup_x(_Atom, [], _X) ->
    -1; %% <-- error condition
layout_binary_tree_lookup_x(Atom, [{Atom,_Y}|_T], X) ->
    X;
layout_binary_tree_lookup_x(Atom, [_H|T], X) ->
    layout_binary_tree_lookup_x(Atom, T, X+1).

%% 
%% Lookup y-coord of an atom in the list
%%
layout_binary_tree_lookup_y(_Atom, []) ->
    -1; %% <-- error condition
layout_binary_tree_lookup_y(Atom, [{Atom,Y}|_T]) ->
    Y;
layout_binary_tree_lookup_y(Atom, [_H|T]) ->
    layout_binary_tree_lookup_y(Atom, T).

%% =============================================================================
%% @doc
%% P67 (**) A string representation of binary trees.
%%
%% Somebody represents binary trees as strings of the following type (see
%% example opposite):
%%
%% a(b(d,e),c(,f(g,)))
%%
%% (a) Write a list function which generates this string, if the tree is given
%%     as usual (as nil or (X L R)). Then write a function which does the 
%%     inverse, i.e., given the string representation, construct the tree in 
%%     the usual form.
%%
%% @end
%% =============================================================================
-spec binary_tree_to_string(Tree) -> String when
      Tree :: term() | [term()],
      String :: [term()].

binary_tree_to_string(Tree) ->
    lists:concat(binary_tree_to_string_rec(Tree)).

binary_tree_to_string_rec(nil) ->
    "";
binary_tree_to_string_rec([Root, nil, nil]) ->
    [Root];
binary_tree_to_string_rec([Root, Left, Right]) ->
    [Root] ++ 
	["("] ++ binary_tree_to_string_rec(Left) ++ 
	[","] ++ binary_tree_to_string_rec(Right) ++ 
	[")"].

-spec string_to_binary_tree(String) -> Tree when
      String :: [term()],
      Tree :: term() | [term()].

string_to_binary_tree(_String) ->
    todo.

%% =============================================================================
%% @doc
%% P68 (**) Preorder and inorder sequences of binary trees.
%%
%% We consider binary trees with nodes that are identified by single lower-case 
%% letters, as in the example of problem B67.
%%
%% a) Write functions preorder and inorder that construct the preorder and
%%    inorder sequence of a given binary tree, respectively. The results should
%%    be lists, e.g., (A B D E C F G) for the preorder sequence of the example 
%%    in P67.
%%
%% b) Can you write the inverse of preorder from problem part a), i.e., given 
%%    a preorder sequence, construct a corresponding tree?
%%
%% c) If both the preorder sequence and the inorder sequence of the nodes of a 
%%    binary tree are given, then the tree is determined unambiguously. Write a 
%%    function pre-in-tree that does the job.
%% @end
%% =============================================================================
-spec preorder(Tree) -> List when
      Tree :: term() | [term()],
      List :: [term()].

preorder([Root, nil, nil]) ->
    [Root];
preorder([Root, Left, nil]) ->
    [Root] ++ preorder(Left);
preorder([Root, nil, Right]) ->
    [Root] ++ preorder(Right);
preorder([Root, Left, Right]) ->
    [Root] ++ preorder(Left) ++ preorder(Right).

-spec inorder(Tree) -> List when
      Tree :: term() | [term()],
      List :: [term()].

inorder([Root, nil, nil]) ->
    [Root];
inorder([Root, Left, nil]) ->
    inorder(Left) ++ [Root];
inorder([Root, nil, Right]) ->
    [Root] ++ inorder(Right);
inorder([Root, Left, Right]) ->
    inorder(Left) ++ [Root] ++ inorder(Right).

%%
%% In answer to question (b), no we cannot write the inverse of preorder, since
%% the inverse mapping is not unique. That is, more than one binary tree can 
%% generate the same preorder list sequence.
%%
%% For instance, consider the following trees:
%%
%%  A = [a, [b, [c, [d, nil, nil], nil], nil], nil].
%%  B = [a, nil, [b, nil, [c, nil, [d, nil, nil]]]].
%%
%% Both of these binary trees have the same preorder sequence:
%%
%% > preorder(A).
%% ==> [a, b, c, d]
%%
%% > preorder(B).
%% ==> [a, b, c, d]
%%
%% Note, however, that their inorder sequences differ:
%%
%% > inorder(A).
%% ==> [d, c, b, a]
%%
%% > inorder(B).
%% ==> [a, b, c, d]
%%

%%
%% We can change this by adding a token for an empty tree, e.g., a ".":
%%
-spec full_preorder(Tree) -> List when
      Tree :: term() | [term()],
      List :: [term()].

full_preorder(nil) ->
    ".";
full_preorder([Root, Left, Right]) when is_atom(Root) ->
    atom_to_list(Root) ++ full_preorder(Left) ++ full_preorder(Right);
full_preorder([Root, Left, Right]) when is_integer(Root) ->
    integer_to_list(Root) ++ full_preorder(Left) ++ full_preorder(Right).

%%
%% Now, for instance, we have:
%%
%% > full_preorder(A).
%% ==> abcd.....
%%
%% > full_preorder(B).
%% ==> a.b.c.d..
%%

%%
%% With this data representation, we can build a binary tree from a full 
%% pre-ordering as follows:
%%
-spec pre_full_tree(String) -> Tree when
      String :: [term()],
      Tree :: term() | [term()].

pre_full_tree(String) ->
    pre_full_tree_stream(string_stream(String)).

pre_full_tree_stream(Stream) ->
    string_stream_next(Stream),
    receive
	{next, Value} ->
	    case Value of
		"." ->
		    %% Terminate recursion
		    make_binary_tree();
		_ ->
		    %% Helper function to support both strings and integers
		    HeadValue = hd(Value),
		    ConvertValue = fun() when HeadValue >= 49, HeadValue =< 57 ->
					   list_to_integer(Value);
				      () ->
					   list_to_atom(Value)
				   end,
		    
		    %% Recursive call
		    make_binary_tree(ConvertValue(),
				     pre_full_tree_stream(Stream),
				     pre_full_tree_stream(Stream))
	     end;
	_ ->
	    %% Default case (shouldn't hit here, though)
	    ok
    end.

%%
%% Supporting "string stream" procedures, implemented as PIDs.
%%       
-spec string_stream(String) -> pid() when
      String :: [term()].

string_stream(Value) ->
    spawn(fun() -> string_stream_make(Value) end).

%%
%% A "string stream" supports two messages:
%%
%%  1. value -> report the present "full" value of the string.
%%  2. next -> return the first character in the stream, and increment forward.
%%
string_stream_make(Value) ->
    receive
	{value, Pid} ->
	    Pid ! {value, Value},
	    string_stream_make(Value);
	{next, Pid} ->
	    Length = length(Value),
	    case Length of 
		0 ->
		    Pid ! {next, []};
		_ ->
		    NewValue = string:substr(Value,2),
		    Pid ! {next, [hd(Value)]},
		    string_stream_make(NewValue)
            end
    end.

-spec string_stream_value(Pid) -> no_return() when
      Pid :: pid().
string_stream_value(Pid) ->
    Pid ! {value, self()}.

-spec string_stream_next(Pid) -> no_return() when
      Pid :: pid().
string_stream_next(Pid) ->
    Pid ! {next, self()}.

%%
%% TODO --> part (c)
%%
-spec pre_in_tree(PreOrderList, InOrderList) -> Tree when
      PreOrderList :: [term()],
      InOrderList :: [term()],
      Tree :: term() | [term()].

pre_in_tree(_PreOrder,_InOrder) ->
    todo.

%% =============================================================================
%% @doc
%% P69 (**) Dotstring representation of binary trees.
%%
%% We consider again binary trees with nodes that are identified by single 
%% lower-case letters, as in the example of problem P67. Such a tree can be 
%% represented by the preorder sequence of its nodes in which dots (.) are 
%% inserted where an empty subtree (nil) is encountered during the tree 
%% traversal. For example, the tree shown in P67 is represented as 
%% "ABD..E..C.FG...". First, try to establish a syntax (BNF or syntax diagrams)
%% and then write functions tree and dotstring which do the conversion.
%% @end
%% =============================================================================

%%
%% This problem has already been solved(!)
%%
%% The 'full_preorder' procedure takes a binary tree and converts it to the
%% "dotstring" syntax representation.
%%
%% The 'pre_full_tree' procedure takes a "dotstring" syntax representation and 
%% converts it to a binary tree.
%%

%%
%% ========================== 
%%  PART V -- MULTIWAY TREES
%% ==========================
%%

%% ===========================================================================
%% @doc
%% P70B (*) Check whether a given expression represents a multiway tree.
%%
%% Write a function 'istree' which succeeds if and only if its argument is a
%% Lisp expression representing a multiway tree.
%% @end
%%
%% Example:
%% > (istree '(a (f g) c (b d e)))
%% > true
%% ===========================================================================

%%
%% The problem is more subtle than might at first appear. 
%%
%% What we're really trying to guard against are cases where the first element
%% in the list is itself a list, i.e., cases where for instance [[a, b],c], or
%% for that matter, [a,[[b,c],d]], which are NOT examples of valid multiway 
%% trees.
%%
%% Knowing this, we can design the predicate as follows:
%%
-spec is_multi_tree(Tree) -> boolean() when 
      Tree :: term() | [term()].

is_multi_tree([H|_T]) when is_list(H) ->
    false;
is_multi_tree(Tree) ->
    is_multi_tree_rec(Tree).

is_multi_tree_rec([]) ->
    true;
is_multi_tree_rec(X) when is_atom(X); is_number(X)->
    true;
is_multi_tree_rec([H|T]) when is_atom(H); is_number(H) ->
    is_multi_tree_rec(T);
is_multi_tree_rec([H|T]) when is_list(H) ->
    is_multi_tree(H) and is_multi_tree_rec(T).

%% 
%% Some helper methods for the multitree section:
%%
make_multi_tree(0) ->
    [];
make_multi_tree(1) ->
    a;
make_multi_tree(2) ->
    b;
make_multi_tree(3) ->
    1;
make_multi_tree(4) ->
    [a];
make_multi_tree(5) ->
    [1];
make_multi_tree(6) ->
    [a, b];
make_multi_tree(7) ->
    [a, [b, c]];
make_multi_tree(8) ->
    [b, d, e];
make_multi_tree(9) ->
    [a, [f, g], c, [b, d, e]];
make_multi_tree(10) ->
    [a, [f, g], [b, d, e]];
make_multi_tree(11) ->
    [a, [b, [c, d]]];
make_multi_tree(12) ->
    [a, [b, [c, [d, e]]]].

%%
%% The following methods generate "false" multiway trees, which should fail 
%% the predicate defined above:
%%
make_multi_tree_fake(1) ->
    [[a,b],c];
make_multi_tree_fake(2) ->
    [a,[[b,c],d]].

%% ===========================================================================
%% @doc
%% P70C (*) Count the nodes of a multiway tree.
%%
%% Write a function nnodes which counts the nodes of a given multiway tree.
%% @end
%%
%% Example:
%% > (nnodes '(a f))
%% > 2
%% ===========================================================================
-spec nnodes(Tree) -> non_neg_integer() when 
      Tree :: term() | [term()].

nnodes([]) ->
    0;
nnodes(X) when is_atom(X); is_number(X) ->
    1;
nnodes([H|T]) when is_atom(H); is_number(H) ->
    nnodes(T) + 1;
nnodes([H|T]) when is_list(H) ->
    nnodes(H) + nnodes(T).

%% ===
%% @doc
%% P70 (**) Tree construction from a node string.
%% 
%% TODO
%% @end
%% ====

multi_tree_2_string(_Tree) ->
    todo.

%% THIS IS WRONG
%%multi_tree_2_string(Tree) ->
%%    multi_tree_2_string(Tree, [], 0).

%%multi_tree_2_string([], Acc, 0) ->
%%    lists:concat(Acc);
%%multi_tree_2_string([], Acc, Depth) when Depth > 0 ->
%%    multi_tree_2_string([], Acc ++ ["^"], Depth-1);
%%multi_tree_2_string(X, Acc, Depth) when is_atom(X); is_number(X) ->
%%    multi_tree_2_string([], Acc ++ [X], Depth+1);
%%multi_tree_2_string([H|T], Acc, Depth) when is_atom(H); is_number(H) ->
%%    multi_tree_2_string(T, Acc ++ [H], Depth+1);
%%multi_tree_2_string([H|T], Acc, Depth) when is_list(H) ->
%%    Val1 = multi_tree_2_string(H, [], 0),
%%    multi_tree_2_string(T, Acc ++ Val1 ++ ["^"], Depth+1).

%% =============================================================================
%% @doc
%% P71 (*) Determine the internal path length of a tree.
%%
%% We define the internal path length of a multiway tree as the total sum of 
%% the path lengths from the root to all nodes of the tree. By this definition,
%% the tree in the figure of P70 has an internal path length of 9. Write a 
%% function (ipl tree) to compute it.
%% @end
%% =============================================================================

ipl([]) ->
    0;
ipl(X) when is_atom(X); is_number(X) ->
    0;
ipl([_H|T]) ->
    ipl_recur(T, 1).

ipl_recur([], _Depth) ->
    0;
ipl_recur([H|T], Depth) when is_atom(H); is_number(H) ->
    ipl_recur(T, Depth) + Depth;
ipl_recur([H|T], Depth) when is_list(H) ->
    ipl_recur(tl(H), Depth+1) + ipl_recur(T, Depth) + Depth.

%% ============================================================================
%% @doc
%% P72 (*) Construct the bottom-up order sequence of the tree nodes.
%%
%% Write a function (bottom-up mtree) which returns the bottom-up sequence of 
%% the nodes of the multiway tree 'mtree' as a Lisp list.
%% @end
%% ============================================================================
bottom_up(_Tree) ->
    todo.

%%
%% ================== 
%%  PART VI - GRAPHS
%% ================== 
%%

%%
%% A graph is defined as a set of nodes and a set of edges, where each edge
%% is a pair of nodes.
%%

%%
%% There are several ways to represent graphs in Lisp. One method is to
%% represent the whole graph as one data object. According to the definition
%% of the graph as a pair of two sets (nodes and edges), we may use the 
%% following Lisp expression to represent the example graph:
%%
%%  ((b c d f g h k) ( (b c) (b f) (c f) (f k) (g h) ))
%%
%% We call this "graph-expression" form. Note, that the lists are kept sorted,
%% they are really sets, without duplicated elements. Each edge appears only 
%% once in the edge list; i.e., an edge from a node x to another node y is 
%% represented as (x y), the expression (y x) is not present. The graph-
%% expression form is our default representation. In Common Lisp there are 
%% pre-defined functions to work with sets.
%%
%% A third representation method is to associate with each node the set of 
%% nodes that are adjacent to that node. We call this the "adjacency-list" 
%% form. In our example:
%%
%%  ( (b (c f)) (c (b f)) (d ()) (f (b c k)) ...)
%%
%% When the edges are directed we call them "arcs". These are represented by
%% ordered pairs. Such a graph is called a directed graph. To represent a 
%% directed graph, the forms discussed above are slightly modified. The example
%% graph opposite is represented as follows:
%%
%%  Graph-expression form
%%   ( (r s t u v) ( (s r) (s u) (u r) (u s) (v u) ) )
%%
%%  Adjacency-list form
%%
%%   ( (r ()) (s (r u)) (t ()) (u (r)) (v (u)) )
%%
%% Note that the adjacency-list does not have the informoation on whether 
%% it is a graph or a digraph.
%%
%% Finally, graphs and digraphs may have additional information attached to 
%% nodes and edges (arcs). For the nodes, this is no problem, as we can 
%% easily replace the single symbol identifiers with arbitrary symbolic 
%% expressions, such as ("London" 4711). On the other hand, for edges we 
%% have to extend our notation. Graphs with additional information attached
%% to edges are called "labelled graphs".
%% 
%%  Graph-expression form
%%   ( (k m p q) ( (m p 7) (p m 5) (p q 9) ) )
%%
%%  Adjacency-list form
%%   ( (k ()) (m ((q 7))) (p ((m 5) (q 9))) (q ()) )
%%
%% Notice how the edge information has been packed into a list with two 
%% elements, the corresponding node and the extra information.
%%
%% The notation for labelled graphs can also be used for so-called "multi-
%% graphs", where more than one edge (or arc) are allowed between two given
%% nodes.
%%  

%%
%% ========================
%%  MISCELLANEOUS PROBLEMS
%% ========================
%%

%% ============================================================================
%% @doc
%% P90 (**) Eight queens problem
%%
%% This is a classic problem in computer science. The objective is to place
%% eight queens on a chessboard so that no two queens are attacking each 
%% other; i.e., no two queens are in the same row, the same column, or on the
%% same diagonal.
%
%% Hint: Represent the position of the queens as a list of numbers 1..N.
%%
%% Example: [4,2,7,3,6,8,5,1] means that the queen in the first column is in 
%% row 4, the queen in the second column is in row 2, etc. Use the generate-
%% and-test paradigm.
%% ============================================================================

%%
%% This solution follows that given in SICP Section 2.2.
%%

%%
%% Define an "accumulate" procedure in Erlang
%% e.g., accumulate(fun erlang:'+'/2, 0, [1,2,3])
%%
-spec accumulate(fun((X,Y) -> Z), T, List) -> List when
      X :: term(),
      Y :: term(),
      Z :: term(),
      T :: term(),
      List :: [term()].

accumulate(_Op, Init, []) ->    
    Init;
accumulate(Op, Init, [H|T]) ->
    Op(H, accumulate(Op, Init, T)).

%%
%% Define a "flatmap" procedure in Erlang
%%
-spec flatmap(fun((X) -> Y), List) -> List when
      X :: integer(),
      Y :: integer(),
      List :: [term()].

flatmap(Proc, List) ->
    accumulate(fun lists:append/2, [], lists:map(Proc, List)).

%%
%% Define an "enumerate_interval" procedure in Erlang
%%
-spec enumerate_interval(X,Y) -> List when
      X :: integer(),
      Y :: integer(),
      List :: [integer()].

enumerate_interval(Start, End) when is_integer(Start), 
				    is_integer(End), 
				    Start >= End ->
    [End];
enumerate_interval(Start, End) when is_integer(Start),
				    is_integer(End) ->
    [Start] ++ enumerate_interval(Start+1, End).

%%
%% Note, the procedure above is "doing it by hand". A quicker, 
%% "cheat" short-cut in Erlang would look like:
%%
%% enumerate_interval(Start, End) -> lists:seq(Start, End).
%%

%%
%% Define an "empty_board" procedure:
%%
-spec queens_empty_board() -> List when
      List :: [term()].

queens_empty_board() ->
    [].

%%
%% Define an "adjoin_position" procedure:
%%
-spec queens_adjoin_position(X, Y, List) -> List when
      X :: pos_integer(),
      Y :: pos_integer(),
      List :: [pos_integer()].

queens_adjoin_position(NewRow, _Column, RestOfQueens) ->
    [NewRow] ++ RestOfQueens.

%%
%% Define a "is_safe" procedure:
%%
-spec queens_is_safe(N, List) -> Bool when
      N :: pos_integer(),
      List :: [pos_integer()],
      Bool :: boolean().

queens_is_safe(_Column, [HPos|TPos]) ->
    SafeIter = fun(_Func, _NewRow, [], _RowOffset) ->
		       true;
		  (Func, NewRow, [CurrentRow|RemainingRows], RowOffset) ->
		       A = (NewRow =:= (CurrentRow)),
		       B = (NewRow =:= (CurrentRow + RowOffset)),
		       C = (NewRow =:= (CurrentRow - RowOffset)),
		       case (A or B or C) of
			   true -> false;
			   false -> Func(Func, NewRow, RemainingRows, RowOffset+1)
		       end
	       end,
    SafeIter(SafeIter, HPos, TPos, 1).

%%
%% Define a helper method for "queens":
%%
-spec queens_cols(X,Y) -> MultiList when
      X :: pos_integer(),
      Y :: pos_integer(),
      List :: [pos_integer()],
      MultiList :: [List].

queens_cols(0, _BoardSize) ->
    [queens_empty_board()];
queens_cols(K, BoardSize) ->
    Pred1 = fun(Positions) ->
		    queens_is_safe(K, Positions)
	    end,
    Pred2 = fun(RestOfQueens) ->
		    Pred3 = fun(NewRow) ->
				    queens_adjoin_position(NewRow, K, RestOfQueens)
			    end,
		    lists:map(Pred3, enumerate_interval(1, BoardSize))
	    end,
    lists:filter(Pred1, flatmap(Pred2, queens_cols(K-1, BoardSize))).

%%
%% Define the "queens" procedure itself:
%%
-spec queens(N) -> MultiList when
      N :: pos_integer(),
      List :: [pos_integer()],
      MultiList :: [List].

queens(BoardSize) ->
    queens_cols(BoardSize, BoardSize).

%%
%% =============== 
%%  DOCUMENTATION 
%% =============== 
%%

%% ==========================================
%% @doc
%% Used just to generate EDoc documentation.
%% @end
%% ========================================== 
document() ->
  edoc:run([],["p99.erl"],[]).
