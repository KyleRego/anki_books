import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "startStudyWithFirstCard", "studyRandomCard", "studyNextCard" ];

  connect() {
    this.cardsToStudy = this.cardsToStudy();
    this.numberOfCards = this.cardsToStudy.length;
    this.startStudyWithFirstCardTarget.addEventListener("click", () => this.startStudyWithFirstCard());
    this.studyRandomCardTarget.addEventListener("click", () => this.studyRandomCard());
    this.studyNextCardTarget.addEventListener("click", () => this.studyNextCard());
  }

  cardsToStudy() {
    return document.querySelectorAll("div[id^=\"note-at-ordinal-position-\"]");
  }

  startStudyWithFirstCard() {
    this.startStudyWithFirstCardTarget.hidden = true;
    this.studyNextCardTarget.hidden = false;
    this.cardsToStudy[0].hidden = false;
    this.ordinalPositionOfCurrentCard = 0;
  }

  studyRandomCard() {
    if (this.startStudyWithFirstCardTarget.hidden === false) {
      this.startStudyWithFirstCardTarget.hidden = true;
      this.studyNextCardTarget.hidden = false;
    } else {
      this.cardsToStudy[this.ordinalPositionOfCurrentCard].hidden = true;
    }
    this.ordinalPositionOfCurrentCard = this.randomOrdinalPosition();
    this.cardsToStudy[this.ordinalPositionOfCurrentCard].hidden = false;
  }

  randomOrdinalPosition() {
    let newRandomOrdinalPosition = Math.floor(Math.random() * this.numberOfCards);
    if (newRandomOrdinalPosition !== this.ordinalPositionOfCurrentCard) {
      return newRandomOrdinalPosition;
    } else {
      return this.nextOrdinalPosition();
    }
  }

  studyNextCard() {
    this.cardsToStudy[this.ordinalPositionOfCurrentCard].hidden = true;
    this.ordinalPositionOfCurrentCard = this.nextOrdinalPosition();
    this.cardsToStudy[this.ordinalPositionOfCurrentCard].hidden = false;
  }

  nextOrdinalPosition() {
    if (this.ordinalPositionOfCurrentCard === this.numberOfCards - 1) {
      return 0;
    } else {
      return this.ordinalPositionOfCurrentCard + 1;
    }
  }
}
