% Implement the procedures below.
% It's ok if a query seems to "hang" as if there is another answer,
% and then produce false if another answer is requested from the user.

% 1. TODO: Write a procedure named myFirst that takes:
%    1.) A list
%    2.) The first element of the list
% Example queries follow:
% ?- myFirst([1, 2, 3], X).
% X = 1.
% ?- myFirst([], X).
% false.
%
% Code expectation: 1 line
% Prolog might issue a singleton variable warning because, in many cases, 
% variables appearing only once are unintentional and may indicate a mistake in the code.
myFirst([First|Rest], First).


% 2. TODO: Write a procedure named myLast that takes:
%    1.) A list
%    2.) The last element of the list
% Example queries follow:
% ?- myLast([1, 2, 3], X).
% X = 3 .
% ?- myLast([1], X).
% X = 1 .
% ?- myLast([], X).
% false.
%
% Code expectation: ~3 lines
myLast([X], X).
% It recursively discards the head of the list until reaching the base case, ensuring X becomes the last element.
myLast([_|T], X) :-
    myLast(T, X).


% 3. TODO: Write a procedure named myInit that takes:
%    1.) A list
%    2.) All the elements of the previous list, without
%        the last element.
% Example queries follow:
% ?- myInit([], X).
% false.
% ?- myInit([1,2,3], X).
% X = [1, 2] .
% ?- myInit([1], X).
% X = [] .
%
% Code expectation: ~3 lines
% The input list has only one element, the result is an empty list. 
myInit([_], []).
% It recursively constructs the result list (Rest) by keeping the head and processing the tail.
myInit([H|T], [H|Rest]) :-
    myInit(T, Rest).


% 4. TODO: Write a procedure named myAppend that takes:
%    1.) A list
%    2.) A second list
%    3.) The result of appending the first and second lists
%        together
% Example queries follow:
% ?- myAppend([1, 2, 3], [4, 5, 6], X).
% X = [1, 2, 3, 4, 5, 6].
% ?- myAppend([], [1, 2, 3], X).
% X = [1, 2, 3].
% ?- myAppend(L1, L2, [1, 2, 3]).
% L1 = [],
% L2 = [1, 2, 3] ;
% L1 = [1],
% L2 = [2, 3] ;
% L1 = [1, 2],
% L2 = [3] ;
% L1 = [1, 2, 3],
% L2 = [] ;
% false.
%
% Note that semicolon (;) was repeatedly pressed in the
% third query above to get all the solutions.
% Code expectation: ~3 lines
% The result of appending an empty list to another list is the other list (unification).
myAppend([], L, L).
myAppend([H|T], L, [H|Result]) :-
    myAppend(T, L, Result).



% 5. TODO: Write a procedure named myLength that takes:
%    1.) A list
%    2.) The length of that list, as an integer
% You may assume that the list will always be provided.
% Example queries follow:
% ?- myLength([], N).
% N = 0.
% ?- myLength([foo], N).
% N = 1.
% ?- myLength([foo, bar], N).
% N = 2.
% ?- myLength([foo, bar, baz], N).
% N = 3.
%
% Code expectation: ~4 lines
% The length of an empty list is 0.
myLength([], 0).
% The length of a list is 1 more than the length of the tail of the list.
myLength([_|T], N) :-
    myLength(T, M),
    N is M + 1.


% 6. TODO: Write a procedure named myFlatten that takes:
%    1.) A possibly nested list
%    2.) A "flattened" version of the list, with all the
%        nested lists removed
% You may assume that the first parameter will always be
% provided.
% Example queries follow:
% ?- myFlatten([], Result).
% Result = [].
% ?- myFlatten([1, 2, 3], Result).
% Result = [1, 2, 3].
% ?- myFlatten([[1, 2, 3]], Result).
% Result = [1, 2, 3] .
% ?- myFlatten([[1, 2, 3], [4, 5, 6]], Result).
% Result = [1, 2, 3, 4, 5, 6] .
% ?- myFlatten([[1, [2, 3]], [[4, 5], 6]], Result).
% Result = [1, 2, 3, 4, 5, 6] .
%
% As a hint, \= can be used to determine if two
% terms do NOT unify; for example, [] \= [A]
% succeeds.
%
% Code expectation: ~12 lines
% This rule states that the flattened version of an empty list is also an empty list.
myFlatten([], []).
% This rule handles the case where X is a list. It recursively calls myFlatten on X and Xs, and then appends the results together.
myFlatten([X|Xs], Result) :-
    myFlatten(X, FlatX),
    myFlatten(Xs, FlatXs),
    append(FlatX, FlatXs, Result).
% This rule handles the case where X is not a list. It wraps the non-list element in a list ([X]), treating it as a single element.
myFlatten(X, [X]) :- \+ is_list(X).



% 7. TODO: Write a procedure named insertPosition that
%    takes:
%    1.) A list
%    2.) An element to insert into the list
%    3.) A position at which to insert the element, starting
%        from zero
%    4.) The resulting list after performing the insertion
% You may assume that the first three parameters will always
% be provided.
% Example queries follow:
% ?- insertPosition([], foo, 0, Result).
% Result = [foo].
% ?- insertPosition([], foo, 1, Result).
% false.
% ?- insertPosition([foo, bar, baz], blah, 0, Result).
% Result = [blah, foo, bar, baz] .
% ?- insertPosition([foo, bar, baz], blah, 1, Result).
% Result = [foo, blah, bar, baz] .
% ?- insertPosition([foo, bar, baz], blah, 2, Result).
% Result = [foo, bar, blah, baz] .
% ?- insertPosition([foo, bar, baz], blah, 3, Result).
% Result = [foo, bar, baz, blah].
% ?- insertPosition([foo, bar, baz], blah, 4, Result).
% false.
%
% Code expectation: ~5 lines
insertPosition(List, Element, Position, Result) :-
    % determine the length of a list or to instantiate a list to a given length
    length(List, Len),
    % generates integers within a given range; ensures that Position is a valid index within the range of the list
    between(0, Len, Position),
    % used to access or modify the element at a specified position in a list
    nth0(Position, Result, Element, List).


% 8. TODO: Write a procedure named insertSorted that takes:
%    1.) A sorted list of integers
%    2.) An integer to insert
%    3.) The result of inserting the integer into the list
%        where the resulting list will be sorted.
% You may assume the first two parameters will always be
% provided.
% You do not need to worry about efficiency.
% Example queries follow:
% ?- insertSorted([], 5, Result).
% Result = [5].
% ?- insertSorted([1, 2, 3, 4], 5, Result).
% Result = [1, 2, 3, 4, 5].
% ?- insertSorted([1, 2, 3, 4], 0, Result).
% Result = [0, 1, 2, 3, 4] .
% ?- insertSorted([1, 2, 3, 4], 3, Result).
% Result = [1, 2, 3, 3, 4] .
%
% Code expectation: ~6 lines

% If the list is empty, it simply creates a new list with the single element X.
insertSorted([], X, [X]).
% If X is less than or equal to the head of the list, it inserts X at the beginning of the list.
insertSorted([H|T], X, Result) :-
    X =< H,
    Result = [X, H | T].
% If X is greater than the head of the list, it recursively calls insertSorted on the tail of the list and then constructs the result list.
insertSorted([H|T], X, Result) :-
    X > H,
    insertSorted(T, X, NewTail),
    Result = [H | NewTail].


% 9. TODO: Write a procedure named insertionSort that
%    takes:
%    1.) A possibly unsorted list of integers
%    2.) The same integers, sorted in ascending order.
% You may assume the first parameter will always be provided.
% Example queries follow:
% ?- insertionSort([], Result).
% Result = [].
% ?- insertionSort([1, 2, 3], Result).
% Result = [1, 2, 3].
% ?- insertionSort([3, 2, 1], Result).
% Result = [1, 2, 3] .
% ?- insertionSort([3, 1, 2], Result).
% Result = [1, 2, 3] .
%
% The following hints may come in handy:
% 1.) You will likely need to introduce a helper procedure
%     which takes an accumulator
% 2.) insertSorted can be used to help
% 3.) Empty lists are always sorted
%
% Code expectation: ~6 lines

% This is the main predicate that users will call
insertionSort(List, Result) :-
    insertionSortAcc(List, [], Result).

% This is a helper predicate with an accumulator 
% The base case is reached when the original list is empty and unifies Ac with the sorted list
insertionSortAcc([], Acc, Acc).
% The recursive case processes each element of the original list, inserting it into the accumulator using insertSorted(3)
insertionSortAcc([H|T], Acc, Result) :-
    insertSorted(Acc, H, NewAcc),
    insertionSortAcc(T, NewAcc, Result).
