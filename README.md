# SwiftConcurrentTaskGroupExample

A SwiftUI demo application showcasing the power of **Swift Concurrency** and **Task Groups** by fetching data from multiple APIs in parallel.

## 🚀 Overview

This project demonstrates two approaches to fetching and displaying a list of quotes with associated images:

- **Sequential Fetching**:  
  Fetching one quote-image pair at a time using `async/await` (sequentially).
  
- **Concurrent Fetching with TaskGroup**:  
  Fetching multiple quote-image pairs concurrently using `withThrowingTaskGroup`, dramatically improving loading speed and user experience.

The app highlights the performance difference between sequential and concurrent data fetching with a real-world SwiftUI List.

---

## 📸 Features

- **SwiftUI** powered responsive UI.
- **TaskGroup** and **async let** usage for maximum parallelism.
- **Actor**-based `WebServices` for thread-safe networking.
- **Loading state management** with a SwiftUI `ProgressView`.
- **NetworkError handling** for clean error propagation.
- **Real API endpoints** (`dummyjson.com/quotes` and `picsum.photos`).

---

## 🛠 Technologies Used

- Swift 5.9
- Swift Concurrency (`async/await`, `TaskGroup`, `async let`)
- SwiftUI
- URLSession
- JSON Decoding (`Codable`)
- Actors

---

## 📂 Project Structure

- `QuoteListView.swift`  
  SwiftUI view displaying a list of quotes and images.

- `QuoteListViewModel.swift`  
  ViewModel managing data fetching and loading states.

- `WebServices.swift`  
  Actor responsible for fetching images and quotes concurrently or sequentially.

- `QuoteItem.swift`  
  Model combining a quote and an image.

---

## 🎥 Performance Demonstration

The repository includes a visual comparison of:

- **Sequential Fetching** (slow loading)
- **Concurrent Fetching with TaskGroup** (fast, progressive loading)

👉 Check the GIFs in the article for side-by-side speed difference!

---

## 🧠 Key Concepts Illustrated

- How to use `withThrowingTaskGroup` to perform **parallel networking tasks** safely.
- How `async let` can run multiple network calls **concurrently inside a single task**.
- When and why to use **Actors** in Swift to ensure **safe concurrency**.
- Best practices for **progressive UI updates** while data is loading.

---

## 📚 Related Article

This project is explained in detail in my Medium article:  
**[Swift Concurrency in Action: Speed Up Your App with Task Groups and Async/Await]()**

*(Link will be updated once the article is live.)*

---

## 👨‍💻 Author

**Serhan Khan**  
- [LinkedIn](https://www.linkedin.com/in/serhan-khan-97b577103/)
- [GitHub](https://github.com/khanboy1989)
- [Medium](https://medium.com/@serhankhan)
- [YouTube - Swift with Serhan](https://www.youtube.com/@SwiftwithSerhan-d7x)

---

## 📜 License

This project is licensed under the MIT License. Feel free to use and adapt it for learning or commercial purposes!
