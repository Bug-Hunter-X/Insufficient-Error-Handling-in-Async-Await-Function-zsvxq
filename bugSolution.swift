func fetchData() async throws -> Data {
    let url = URL(string: "https://api.example.com/data")!
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
        throw URLError(.badServerResponse)
    }
    return data
}

Task { 
    do {
        let data = try await fetchData()
        // Process data
    } catch let error as URLError {
        // Handle specific URLError
        switch error.code {
        case .notConnectedToInternet:
            print("No internet connection")
            // Handle no internet
        case .badServerResponse:
            print("Bad server response")
            // Retry or alert user
        default:
            print("Error fetching data: \(error)")
        }
    } catch {
        print("An unexpected error occurred: \(error)")
    }
}