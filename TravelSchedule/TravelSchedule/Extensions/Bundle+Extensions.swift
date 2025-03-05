import Foundation

extension Bundle {
    var appBuild: String {
        getInfo("CFBundleVersion")
    }
    
    var appVersionLong: String {
        getInfo("CFBundleShortVersionString")
    }
    
    private func getInfo(_ str: String) -> String {
        infoDictionary?[str] as? String ?? ""
    }
}
