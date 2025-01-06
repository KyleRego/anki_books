// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "chooseStudyModeButtons", "studyButtons",
                    "startStudyWithFirstCard", "startRandomOrderStudy",
                    "studyNextCard", "showAnswerBtn",
                    "initialInstructions", "completedStudyingInstructions" ];

  connect() {
    this.cardsToStudy = this.cardsToStudy();
    this.numberOfCards = this.cardsToStudy.length;
  
    this.startStudyWithFirstCardTarget.addEventListener("click", () => this.startStudyWithFirstCard());
    this.startRandomOrderStudyTarget.addEventListener("click", () => this.startRandomOrderStudy());
    this.showAnswerBtnTarget.addEventListener("click", () => this.handleCardShowAnswer());
    this.studyNextCardTarget.addEventListener("click", () => this.studyNextCard());
    
    this.ordinalPositionOfCurrentCard = 0;
  }

  hideInitialInstructions() {
    this.initialInstructionsTarget.hidden = true;
  }

  hideChooseStudyModeButtons() {
    this.chooseStudyModeButtonsTarget.hidden = true;
    // Bootstrap class d-flex has !important so it will
    // override the hidden attribute unless it is removed
    this.chooseStudyModeButtonsTarget.classList.remove("d-flex");
  }

  cardsToStudy() {
    return Array.from(document.querySelectorAll(".studiable-note"));
  }

  currentCard() {
    return this.cardsToStudy[this.ordinalPositionOfCurrentCard];
  }

  startStudyWithFirstCard() {
    this.startStudy();
    this.cardsToStudy[0].hidden = false;
  }

  handleStudyWithRandomCardKeydown(event) {
    if (event.key == "Enter") {
      this.startStudyWithFirstCard();
    }
  }

  startRandomOrderStudy() {
    this.startStudy();
    this.randomizeCards();
  }

  startStudy() {
    this.hideInitialInstructions();
    this.hideChooseStudyModeButtons();
    this.studyButtonsTarget.hidden = false;
  }

  handleCardShowAnswer() {
    this.currentCard().querySelectorAll(".card-question").forEach((element) => {
      element.hidden = true;
    })
    this.currentCard().querySelectorAll(".card-answer").forEach((element) => {
      element.hidden = false;
    });
    this.showAnswerBtnTarget.hidden = true;
    this.studyNextCardTarget.hidden = false;
    this.studyNextCardTarget.focus();
  }

  studyNextCard() {
    this.currentCard().hidden = true;
    this.ordinalPositionOfCurrentCard = this.nextOrdinalPosition();
    if (this.ordinalPositionOfCurrentCard < this.numberOfCards) {
      this.currentCard().hidden = false;
      this.studyNextCardTarget.hidden = true;
      this.showAnswerBtnTarget.hidden = false;
      this.showAnswerBtnTarget.focus();
    } else {
      this.completedStudyingInstructionsTarget.hidden = false;
    }
    
  }

  nextOrdinalPosition() {
    if (this.ordinalPositionOfCurrentCard === (this.numberOfCards - 1)) {
      return 0;
    } else {
      return this.ordinalPositionOfCurrentCard + 1;
    }
  }

  previousOrdinalPosition() {
    if (this.ordinalPositionOfCurrentCard === 0) {
      return this.numberOfCards - 1;
    } else {
      return this.ordinalPositionOfCurrentCard - 1;
    }
  }

  randomizeCards() {
    this.cardsToStudy.sort(() => Math.random() - 0.5);
    this.currentCard().hidden = false;
  }
}
