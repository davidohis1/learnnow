import {
  api,
  toast,
  busy,
  escapeHtml as esc,
  handleSuccess,
  showFormError,
  confirmAction,
} from "./api.js";
const builder = document.querySelector("#question-builder");
if (builder) {
  const initial = document.querySelector("#question-data");
  let questions = initial ? JSON.parse(initial.textContent) : [];
  const list = builder.querySelector("[data-question-list]");
  const blank = () => ({
    type: "single",
    prompt: "",
    explanation: "",
    points: 1,
    options: [
      { label: "", correct: 1 },
      { label: "", correct: 0 },
    ],
  });
  function capture() {
    questions = [...list.querySelectorAll(".question-builder-item")].map(
      (el) => ({
        type: el.querySelector("[data-q-type]").value,
        prompt: el.querySelector("[data-q-prompt]").value,
        points: Number(el.querySelector("[data-q-points]").value),
        explanation: el.querySelector("[data-q-explanation]").value,
        options: [...el.querySelectorAll("[data-option-row]")].map((r) => ({
          label: r.querySelector("[data-option-label]").value,
          correct: r.querySelector("[data-option-correct]").checked,
        })),
      }),
    );
  }
  function draw() {
    list.innerHTML = questions
      .map(
        (q, i) =>
          `<section class="question-builder-item" data-index="${i}"><div class="question-item-header"><strong>Question ${i + 1}</strong><div><button type="button" class="btn btn-ghost btn-small" data-move-up="${i}" ${i === 0 ? "disabled" : ""}>Move up</button><button type="button" class="btn btn-ghost btn-small" data-remove-question="${i}">Remove</button></div></div><div class="form-grid"><div class="field"><label for="q-type-${i}">Question type</label><select id="q-type-${i}" data-q-type>${[
            ["single", "Single answer"],
            ["multiple", "Multiple answers"],
            ["boolean", "True or false"],
            ["short", "Written answer · manual review"],
          ]
            .map(
              ([v, l]) =>
                `<option value="${v}" ${q.type === v ? "selected" : ""}>${l}</option>`,
            )
            .join(
              "",
            )}</select></div><div class="field"><label for="q-points-${i}">Points</label><input id="q-points-${i}" data-q-points type="number" min="1" max="100" required value="${Number(q.points) || 1}"></div><div class="field full"><label for="q-prompt-${i}">Question</label><textarea id="q-prompt-${i}" data-q-prompt required minlength="3" maxlength="3000">${esc(q.prompt)}</textarea></div></div><div class="answer-editor ${q.type === "short" ? "is-hidden" : ""}"><span class="field-label">Answer options · tick every correct answer</span>${(q.options || []).map((o, j) => `<div class="answer-option-row" data-option-row><input data-option-correct type="checkbox" aria-label="Option ${j + 1} is correct" ${o.correct ? "checked" : ""}><input class="input" data-option-label type="text" aria-label="Option ${j + 1} text" maxlength="1000" value="${esc(o.label)}" placeholder="Answer option"><button type="button" class="icon-button" data-remove-option="${i},${j}" aria-label="Remove option">×</button></div>`).join("")}<button type="button" class="btn btn-secondary btn-small" data-add-option="${i}">+ Add option</button></div><div class="field" style="margin-top:18px"><label for="q-explanation-${i}">Explanation · shown when answer review is enabled</label><textarea id="q-explanation-${i}" data-q-explanation maxlength="4000">${esc(q.explanation)}</textarea></div></section>`,
      )
      .join("");
  }
  draw();
  builder.addEventListener("click", (e) => {
    const add = e.target.closest("[data-add-question]"),
      remove = e.target.closest("[data-remove-question]"),
      up = e.target.closest("[data-move-up]"),
      addOption = e.target.closest("[data-add-option]"),
      removeOption = e.target.closest("[data-remove-option]");
    if (!add && !remove && !up && !addOption && !removeOption) return;
    capture();
    if (add) {
      if (questions.length >= 50)
        return toast("A quiz can contain up to fifty questions.", "error");
      questions.push(blank());
    }
    if (remove) questions.splice(Number(remove.dataset.removeQuestion), 1);
    if (up) {
      const i = Number(up.dataset.moveUp);
      [questions[i - 1], questions[i]] = [questions[i], questions[i - 1]];
    }
    if (addOption) {
      const i = Number(addOption.dataset.addOption);
      if (questions[i].options.length < 8)
        questions[i].options.push({ label: "", correct: 0 });
    }
    if (removeOption) {
      const [i, j] = removeOption.dataset.removeOption.split(",").map(Number);
      questions[i].options.splice(j, 1);
    }
    draw();
  });
  builder.addEventListener("change", (e) => {
    if (e.target.matches("[data-q-type]")) {
      capture();
      const i = Number(e.target.closest("[data-index]").dataset.index);
      if (questions[i].type === "boolean")
        questions[i].options = [
          { label: "True", correct: 1 },
          { label: "False", correct: 0 },
        ];
      draw();
    }
  });
  builder.addEventListener("submit", async (e) => {
    e.preventDefault();
    capture();
    const button = e.submitter;
    busy(button, true);
    try {
      handleSuccess(await api(builder.action, { questions }));
    } catch (error) {
      showFormError(builder, error);
    } finally {
      busy(button, false);
    }
  });
}
const previewButton = document.querySelector("[data-preview-lesson]");
if (previewButton) {
  previewButton.addEventListener("click", () => {
    const dialog = document.querySelector("#lesson-preview-dialog");
    dialog.querySelector("[data-preview-title]").textContent =
      document.querySelector('[name="title"]').value;
    dialog.querySelector("[data-preview-content]").textContent =
      document.querySelector('[name="content"]').value;
    dialog.showModal();
  });
  document
    .querySelector("[data-close-preview]")
    ?.addEventListener("click", () =>
      document.querySelector("#lesson-preview-dialog").close(),
    );
}
document.querySelectorAll("[data-auto-slug]").forEach((el) =>
  el.addEventListener("input", () => {
    const slug = document.querySelector('[name="slug"]');
    if (slug && !slug.dataset.edited)
      slug.value = el.value
        .toLowerCase()
        .replace(/[^a-z0-9]+/g, "-")
        .replace(/^-|-$/g, "");
  }),
);
document
  .querySelector('[name="slug"]')
  ?.addEventListener("input", (e) => (e.target.dataset.edited = "true"));
for (const [selector, idName, url] of [
  [
    "[data-referral-resolve]",
    "referral_id",
    (id) => `/api/admin/referrals/${id}`,
  ],
  [
    "[data-certificate-revoke]",
    "certificate_id",
    (id) => `/api/admin/certificates/${id}/revoke`,
  ],
]) {
  document.querySelector(selector)?.addEventListener("submit", async (e) => {
    e.preventDefault();
    const form = e.currentTarget;
    const data = new FormData(form);
    const id = data.get(idName);
    if (!id) return;
    if (
      !(await confirmAction(
        idName === "certificate_id"
          ? "Revoke this certificate permanently? Your reason will be visible on the public verification page."
          : "Record this referral decision under the configured eligibility rules?",
      ))
    )
      return;
    const button = e.submitter;
    busy(button, true);
    try {
      handleSuccess(await api(url(id), data));
    } catch (error) {
      showFormError(form, error);
    } finally {
      busy(button, false);
    }
  });
}
