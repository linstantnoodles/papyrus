import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "key", "record" ]
  filter() {
    const searchKey = this.keyTarget.value;

    this.recordTargets.forEach((el, i) => {
        const tags = el.dataset.tags;
        const title = (el.dataset.title || "").toLowerCase();
        if (tags.indexOf(searchKey) >= 0 || title.indexOf(searchKey) >= 0) {
            el.style.display = "table-row";
        } else {
            el.style.display = "none";
        }
    })
  }
}
