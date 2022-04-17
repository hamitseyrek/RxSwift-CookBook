
# RxSwift-CookBook
Practice for Reactive Programming with RxSwift Framework


# ReactiveX
ReactiveX is a library for composing asynchronous and event-based programs by using observable sequences.

It extends the observer pattern to support sequences of data and/or events and adds operators that allow you to compose sequences together declaratively while abstracting away concerns about things like low-level threading, synchronization, thread-safety, concurrent data structures, and non-blocking I/O.

### Observables fill the gap by being the ideal way to access asynchronous sequences of multiple items
single items    multiple items
synchronous    T getData()    Iterable<T> getData()
asynchronous    Future<T> getData()    Observable<T> getData()
It is sometimes called “functional reactive programming” but this is a misnomer. ReactiveX may be functional, and it may be reactive, but “functional reactive programming” is a different animal. One main point of difference is that functional reactive programming operates on values that change continuously over time, while ReactiveX operates on discrete values that are emitted over time. (See Conal Elliott’s work for more-precise information on functional reactive programming.)
