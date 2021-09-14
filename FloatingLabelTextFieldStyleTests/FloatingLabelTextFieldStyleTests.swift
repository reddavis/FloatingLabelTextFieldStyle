import SnapshotTesting
import SwiftUI
import XCTest
@testable import FloatingLabelTextFieldStyle


class FloatingLabelTextFieldStyleTests: XCTestCase
{
    func testDefaultState()
    {
        assertSnapshot(
            matching: TextField("e.g. me@red.to", text: .constant(""))
                .textFieldStyle(
                    .floating(
                        title: .init(text: "Email")
                    )
                ),
            as: .image,
            record: false
        )
    }
    
    func testWithValueState()
    {
        assertSnapshot(
            matching: TextField("e.g. me@red.to", text: .constant("me@red.to"))
                .textFieldStyle(
                    .floating(
                        title: .init(text: "Email")
                    )
                ),
            as: .image,
            record: false
        )
    }
    
    func testWithValueAndHiddenClearButtonState()
    {
        assertSnapshot(
            matching: TextField("e.g. me@red.to", text: .constant("me@red.to"))
                .textFieldStyle(
                    .floating(
                        title: .init(text: "Email"),
                        showClearButton: false
                    )
                ),
            as: .image,
            record: false
        )
    }
    
    func testErrorState()
    {
        assertSnapshot(
            matching: TextField("e.g. me@red.to", text: .constant("💩"))
                .textFieldStyle(
                    .floating(
                        title: .init(text: "Email"),
                        error: .init(text: "💩 is not a valid email address.")
                    )
                ),
            as: .image,
            record: false
        )
    }
}
