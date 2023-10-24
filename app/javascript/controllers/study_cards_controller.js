// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "startStudyWithFirstCard", "startRandomOrderStudy", "studyPreviousCard", "studyNextCard" ];

  initialize() {
    this.boundHandleStudyCardsKeydown = this.handleStudyCardsKeydown.bind(this);

    this.boundHandleStudyWithFirstCardKeydown = this.handleStudyWithFirstCardKeydown.bind(this);
    this.boundHandleStudyWithRandomCardKeydown = this.handleStudyWithRandomCardKeydown.bind(this);
  }

  connect() {
    this.cardsToStudy = this.cardsToStudy();
    this.numberOfCards = this.cardsToStudy.length;
    this.startStudyWithFirstCardTarget.addEventListener("click", () => this.startStudyWithFirstCard());

    this.startStudyWithFirstCardTarget.addEventListener("keydown", this.boundHandleStudyWithFirstCardKeydown);

    this.startRandomOrderStudyTarget.addEventListener("click", () => this.startRandomOrderStudy());

    this.startRandomOrderStudyTarget.addEventListener("keydown", this.boundHandleStudyWithRandomCardKeydown);

    this.studyPreviousCardTarget.addEventListener("click", () => this.studyPreviousCard());
    this.studyNextCardTarget.addEventListener("click", () => this.studyNextCard());
    this.ordinalPositionOfCurrentCard = 0;
  }

  cardsToStudy() {
    return Array.from(document.querySelectorAll(".studiable-note"));
  }

  currentCard() {
    return this.cardsToStudy[this.ordinalPositionOfCurrentCard];
  }

  currentFlippableBack() {
    return this.currentCard().querySelector('[data-basic-note-flippable-target="flippableNoteBack"]');
  }

  handleStudyWithFirstCardKeydown(event) {
    if (event.key == "Enter") {
      this.startStudyWithFirstCard(true);
    }
  }

  startStudyWithFirstCard(usingKeyboard = false) {
    this.startStudy(usingKeyboard);
    this.cardsToStudy[0].hidden = false;
  }

  handleStudyWithRandomCardKeydown(event) {
    if (event.key == "Enter") {
      this.startStudyWithFirstCard(true);
    }
  }

  startRandomOrderStudy(usingKeyboard = false) {
    this.startStudy(usingKeyboard);
    this.randomizeCards();
  }

  startStudy(usingKeyboard = false) {
    this.startStudyWithFirstCardTarget.hidden = true;
    this.startRandomOrderStudyTarget.hidden = true;
    if (usingKeyboard == false) {
      this.studyPreviousCardTarget.hidden = false;
      this.studyNextCardTarget.hidden = false;
    }
    document.addEventListener("keydown", this.boundHandleStudyCardsKeydown);
  }

  handleStudyCardsKeydown(event) {
    if (event.target.tagName !== "textarea") {
      if (event.key === " ") {
        if (this.currentFlippableBack().hidden) {
          this.currentFlippableBack().hidden = false;
        } else {
          this.studyNextCard();
        }
      } else if (event.key === "1") {
        if (!this.currentFlippableBack().hidden) {
          this.currentFlippableBack().hidden = true;
        } else {
          this.studyPreviousCard();
        }
      }
    }
  }

  studyNextCard() {
    this.currentCard().hidden = true;
    this.ordinalPositionOfCurrentCard = this.nextOrdinalPosition();
    this.currentCard().hidden = false;
  }

  studyPreviousCard() {
    this.currentCard().hidden = true;
    this.ordinalPositionOfCurrentCard = this.previousOrdinalPosition();
    this.currentCard().hidden = false;
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
