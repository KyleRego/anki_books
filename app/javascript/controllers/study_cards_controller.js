import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "startStudyWithFirstCard", "startRandomOrderStudy", "studyPreviousCard", "studyNextCard" ];

  connect() {
    this.cardsToStudy = this.cardsToStudy();
    this.numberOfCards = this.cardsToStudy.length;
    this.startStudyWithFirstCardTarget.addEventListener("click", () => this.startStudyWithFirstCard());
    this.startRandomOrderStudyTarget.addEventListener("click", () => this.startRandomOrderStudy());
    this.studyPreviousCardTarget.addEventListener("click", () => this.studyPreviousCard());
    this.studyNextCardTarget.addEventListener("click", () => this.studyNextCard());
    this.ordinalPositionOfCurrentCard = 0;
  }

  cardsToStudy() {
    return Array.from(document.querySelectorAll(".studiable-note"));
  }

  startStudyWithFirstCard() {
    this.startStudy();
    this.cardsToStudy[0].hidden = false;
  }

  startRandomOrderStudy() {
    this.startStudy();
    this.randomizeCards();
  }

  startStudy() {
    this.startStudyWithFirstCardTarget.hidden = true;
    this.startRandomOrderStudyTarget.hidden = true;
    this.studyPreviousCardTarget.hidden = false;
    this.studyNextCardTarget.hidden = false;
  }

  studyNextCard() {
    this.cardsToStudy[this.ordinalPositionOfCurrentCard].hidden = true;
    this.ordinalPositionOfCurrentCard = this.nextOrdinalPosition();
    this.cardsToStudy[this.ordinalPositionOfCurrentCard].hidden = false;
  }

  studyPreviousCard() {
    this.cardsToStudy[this.ordinalPositionOfCurrentCard].hidden = true;
    this.ordinalPositionOfCurrentCard = this.previousOrdinalPosition();
    this.cardsToStudy[this.ordinalPositionOfCurrentCard].hidden = false;
  }

  nextOrdinalPosition() {
    if (this.ordinalPositionOfCurrentCard === this.numberOfCards - 1) {
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
    this.cardsToStudy[this.ordinalPositionOfCurrentCard].hidden = false;
  }
}
