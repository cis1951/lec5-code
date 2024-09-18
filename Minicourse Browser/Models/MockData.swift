//
//  MockData.swift
//  Minicourse Browser
//
//  Created by the CIS 1951 team on 2/15/24.
//

extension Course {
    static let minicourses: [Course] = [
        .init(
            code: "CIS 1902",
            name: "Python Programming",
            description: "Python is an elegant, concise, and powerful language that is useful for tasks large and small. Python has quickly become a popular language for getting things done efficiently in many in all domains: scripting, systems programming, research tools, and web development. This course will provide an introduction to this modern high-level language using hands-on experience through programming assignments and a collaborative final application development project.",
            icon: "applescript"
        ),
        .init(
            code: "CIS 1905",
            name: "Rust Programming",
            description: "Rust is a new, practical, community-developed systems programming language that \"runs blazingly fast, prevents almost all crashes, and eliminates data ra (rust-lang.org). Rust derives from a rich history of languages to create a multi-paradigm (imperative/functional), low-level language that focuses on high-performance, zero-cost safety guarantee in concurrent programs. It has begun to gain traction in industry, showing a recognized need for a new low-level systems language. In this course, we will cover what makes Rust so unique and apply it to practical systems programming problems. Topics covered will include traits and generics; memory safety (move semantics, borrowing, and lifetimes); Rust's rich macro system; closures; and concurrency. Evaluation is based on regular homework assignments as well as a final project and class participation. Prerequisite: CIS 1200 Recommended additional prerequisite: CIS 2400 or exposure to C or C++",
            icon: "cpu"
        ),
        .init(
            code: "CIS 1912",
            name: "DevOps",
            description: "DevOps is the breaking down of the wall between Developers and Operations to allow more frequent and reliable feature deployments. Through a variety of automation-focused techniques, DevOps has the power to radically improve and streamline processes that in the past were manual and susceptible to human error. In this course we will take a practical, hands-on look at DevOps and dive into some of the main tools of DevOps: automated testing, containerization, reproducibility, continuous integration, and continuous deployment. Throughout the semester we build toward an end-to-end pipeline that takes a webserver, packages it, and then deploys it to the cloud in a reliable and quickly-reproducible manner utilizing industry-leading technologies like Kubernetes and Docker. Evaluation is based on homework assignments and a final group project.",
            icon: "externaldrive.trianglebadge.exclamationmark"
        ),
        .init(
            code: "CIS 1921",
            name: "Solving Hard Problems in Practice",
            description: "What does Sudoku have in common with debugging, scheduling exams, and routing shipments? All of these problems are provably hard -- no one has a fast algorithm to solve them. But in reality, people are quickly solving these problems on a huge scale with clever systems and heuristics! In this course, we'll explore how researchers and organizations like Microsoft, Google, and NASA are solving these hard problems, and we'll get to use some of the tools they've built!",
            icon: "exclamationmark.questionmark"
        ),
        .init(
            code: "CIS 1951",
            name: "iOS Programming",
            description: "This project-oriented course is centered around application development on current iOS mobile platforms. The first half of the course will involve fundamentals of mobile app development, where students learn about mobile app lifecycles, event-based programming, efficient resource management, and how to interact with the range of sensors available on modern mobile devices. In the second half of the course, students work in teams to conceptualize and develop a significant mobile application. Creativity and originality are highly encouraged! Prerequisite: CIS 1200 or previous programming experience. ",
            icon: "iphone"
        ),
    ]
}
