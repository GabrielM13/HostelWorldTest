//  HostelWorldUITests.swift
//  HostelWorldUITests
//
//  Created by Gabriel on 09/12/24.
//

import XCTest

final class HostelWorldUITests: XCTestCase {

    override func setUpWithError() throws {
        // Configurações antes de cada teste
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Limpeza após cada teste
    }

    @MainActor
    func testPropertyListViewElementsExist() throws {
        let app = XCUIApplication()
        app.launch()

        // Verifica se o título aparece
        XCTAssertTrue(app.navigationBars["Properties"].exists, "O título 'Properties' não está visível.")

        // Verifica elementos do primeiro item
        let firstCell = app.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "O primeiro item da lista não foi encontrado.")
    }

    @MainActor
    func testNavigateToPropertyDetailsAndVerifyElements() throws {
        let app = XCUIApplication()
        app.launch()

        // Toca no primeiro item
        let firstCell = app.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "O primeiro item da lista não foi encontrado.")
        firstCell.tap()

        // Verifica se a tela de detalhes foi aberta
        XCTAssertTrue(app.navigationBars["Details"].exists, "A navegação para a tela de detalhes falhou.")
    }
}

