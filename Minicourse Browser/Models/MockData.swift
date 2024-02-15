//
//  MockData.swift
//  Minicourse Browser
//
//  Created by the CIS 1951 team on 2/15/24.
//

extension Course {
    static let minicourses: [Course] = [
        .init(
            code: "CIS 1901",
            name: "C++ Programming",
            description: "This course will provide an introduction to programming in C++ and is intended for students who are already experienced with programming in C and in object-oriented languages such as Java. C++ provides programmers with a greater level of control over machine resources and is commonly used in situations where low level access or performance are important. This course will cover the features and abstractions that C++ provides to write code that is both safe and performant. This course recommends students to have completed CIS 1200 and CIS 2400.",
            icon: "memorychip"
        ),
        .init(
            code: "CIS 1902",
            name: "Python Programming",
            description: "Python is an elegant, concise, and powerful language that is useful for tasks large and small. Python has quickly become a popular language for getting things done efficiently in many in all domains: scripting, systems programming, research tools, and web development. This course will provide an introduction to this modern high-level language using hands-on experience through programming assignments and a collaborative final application development project.",
            icon: "applescript"
        ),
        .init(
            code: "CIS 1904",
            name: "Introduction to Haskell Programming",
            description: "Haskell is a high-level, purely functional programming language with a strong static type system and elegant mathematical underpinnings. It is being increasingly used in industry by organizations such as Facebook, AT&T, and NASA, along with several financial firms. We will explore the joys of functional programming, using Haskell as a vehicle. The aim of the course will be to allow you to use Haskell to easily and conveniently write practical programs. Evaluation will be based on regular homework assignments and class participation.",
            icon: "function"
        ),
        .init(
            code: "CIS 1905",
            name: "Rust Programming",
            description: "Rust is a new, practical, community-developed systems programming language that \"runs blazingly fast, prevents almost all crashes, and eliminates data ra (rust-lang.org). Rust derives from a rich history of languages to create a multi-paradigm (imperative/functional), low-level language that focuses on high-performance, zero-cost safety guarantee in concurrent programs. It has begun to gain traction in industry, showing a recognized need for a new low-level systems language. In this course, we will cover what makes Rust so unique and apply it to practical systems programming problems. Topics covered will include traits and generics; memory safety (move semantics, borrowing, and lifetimes); Rust's rich macro system; closures; and concurrency. Evaluation is based on regular homework assignments as well as a final project and class participation. Prerequisite: CIS 1200 Recommended additional prerequisite: CIS 2400 or exposure to C or C++",
            icon: "cpu"
        ),
        .init(
            code: "CIS 1951",
            name: "iOS Programming",
            description: "This project-oriented course is centered around application development on current iOS mobile platforms. The first half of the course will involve fundamentals of mobile app development, where students learn about mobile app lifecycles, event-based programming, efficient resource management, and how to interact with the range of sensors available on modern mobile devices. In the second half of the course, students work in teams to conceptualize and develop a significant mobile application. Creativity and originality are highly encouraged! Prerequisite: CIS 1200 or previous programming experience. ",
            icon: "iphone"
        ),
        .init(
            code: "CIS 1962",
            name: "JavaScript Programming",
            description: "This course provides an introduction to modern web development frameworks, techniques, and practices used to deliver robust client side applications on the web. The emphasis will be on developing JavaScript programs that run in the browser. Topics covered include the JavaScript language, web browser internals, the Document Object Model (DOM), HTML5, client-side app architecture and compile-to-JS languages like (Coffeescript, TypeScript, etc.). This course is most useful for students who have some programming and web development experience and want to develop moderate JavaScript skills to be able to build complex, interactive applications in the browser.",
            icon: "macwindow.and.cursorarrow"
        ),
    ]
}
