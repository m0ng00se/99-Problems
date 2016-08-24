/* ======================================================= *
 *                  99 QUESTIONS IN SWIFT                  *
 * ------------------------------------------------------- *
 *                                                         *
 * Reference for the Lisp questions: http://bit.ly/1id79HU *
 * ======================================================= */

import Foundation

/* ============================ *
 * PART I -- LIST MANIPULATIONS *
 * ============================ */

// =====================================
// P01 (*) Find the last box of a list.
// Example:
// > (my-last '(a b c d))
// > (d)
// =====================================
func my_last_iter<T>(tail: [T]?, head: T?) -> T? {
    if let tailSequence = tail {
        if !tailSequence.isEmpty {
            return my_last_iter(tail: Array(tailSequence.dropFirst()), head: tailSequence[0])
        }
    }
    return head
}

func my_last<T>(_ list: [T]?) -> T? {
    return my_last_iter(tail: list, head: nil)
}

// Overload with concrete type so we can correctly infer default type for, e.g., my_last(nil) or my_last([])
func my_last(_ list: [Int]?) -> Int? {
    return my_last_iter(tail: list, head: nil)
}

my_last(nil)
my_last([])
my_last([1])
my_last([1,2])
my_last([1,2,3])
my_last(["one"])
my_last(["one", "two"])
my_last(["one", "two", "three"])

// CHEAT:
// public var lastObject: AnyObject? { get }
// public var last: Self.Iterator.Element? { get }
[].lastObject
[1].last
[1,2].last
[1,2,3].last
["one"].last
["one", "two"].last
["one", "two", "three"].last
