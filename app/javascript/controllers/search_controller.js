import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "tag", "record" ]
  filter() {
    const tagValue = this.tagTarget.value;
    this.recordTargets.forEach((el, i) => {
        const tags = el.dataset.tags;
        if (tags.indexOf(tagValue) >= 0) {
            el.style.display = "table-row";
        } else {
            el.style.display = "none";
        }
    })
  }
}
