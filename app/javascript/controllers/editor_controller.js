import { Controller } from 'stimulus';

export default class extends Controller {
  initialize() {
    this.postId = this.element.getAttribute('data-post-id');
    this.form = document.getElementsByTagName('form')[0];
    this.textArea = document.getElementById('edit-entry-content');
    let debouncedSave = window.lodash.debounce((event) => {
      let url = this.form.action;
      let data = {
        title: document.getElementById('post-title').value,
        content: this.textArea.value,
        post_id: document.getElementById('post_id').value,
        tags: document.getElementById('edit-post-tags').value
      };
      fetch(url, {
        method: 'PATCH',
        headers: new Headers({
          'X-CSRF-Token': document.querySelector('input[name="authenticity_token"]').value,
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
        }),
        redirect: 'manual',
        body: Object.keys(data).map((x) => { return `${x}=${data[x]}` }).join('&')
      }).then(() => {
        this.textArea.style.border = "solid #90EE90 1px";
        window.setTimeout(() => {
          this.textArea.style.border = "";
        }, 1000);
      })
    }, 1000);
    this.textArea.addEventListener('keypress', debouncedSave);
  }
}