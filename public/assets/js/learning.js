import {
  api,
  toast,
  busy,
  confirmAction,
  handleSuccess,
  showFormError,
} from "./api.js";
document.querySelectorAll("[data-checklist-id]").forEach((box) =>
  box.addEventListener("change", async () => {
    const checked = box.checked;
    box.disabled = true;
    try {
      await api(`/api/checklist/${box.dataset.checklistId}`, {
        completed: checked,
      });
      box.closest("label")?.classList.toggle("is-checked", checked);
    } catch (e) {
      box.checked = !checked;
      toast(e.message, "error");
    } finally {
      box.disabled = false;
    }
  }),
);
const notes = document.querySelector("[data-private-notes]");
if (notes) {
  let timeout,
    inFlight = null,
    saved = notes.value,
    version = Number(notes.dataset.noteVersion || 0);
  const status = document.querySelector("[data-notes-status]"),
    form = notes.closest("form");
  const dirty = () => notes.value !== saved;
  const message = (text) => {
    if (status) status.textContent = text;
  };
  async function save(manual = false) {
    clearTimeout(timeout);
    if (inFlight) {
      await inFlight;
      return dirty() ? save(manual) : true;
    }
    if (!dirty()) {
      if (manual) toast("Your notes are up to date.");
      return true;
    }
    const snapshot = notes.value;
    message("Saving your private notes…");
    inFlight = (async () => {
      try {
        const result = await api(notes.dataset.privateNotes, {
          content: snapshot,
          version,
        });
        version = result.version;
        saved = snapshot;
        message(
          dirty()
            ? "Unsaved changes"
            : "All changes saved · only you can see this",
        );
        if (manual) toast(result.message);
        return true;
      } catch (error) {
        message(error.message);
        return false;
      }
    })();
    const ok = await inFlight;
    inFlight = null;
    if (ok && dirty()) return save(manual);
    return ok;
  }
  notes.addEventListener("input", () => {
    clearTimeout(timeout);
    message("Unsaved changes");
    timeout = setTimeout(() => save(), 1500);
  });
  form.addEventListener("submit", async (event) => {
    event.preventDefault();
    const button = event.submitter;
    busy(button, true);
    try {
      await save(true);
    } finally {
      busy(button, false);
    }
  });
  window.addEventListener("beforeunload", (event) => {
    if (dirty()) {
      event.preventDefault();
      event.returnValue = "";
    }
  });
  document.addEventListener("visibilitychange", () => {
    if (document.hidden && dirty()) save();
  });
  document.addEventListener(
    "click",
    async (event) => {
      const link = event.target.closest("a[href]");
      if (
        !link ||
        !dirty() ||
        event.button !== 0 ||
        event.metaKey ||
        event.ctrlKey ||
        event.shiftKey ||
        link.target === "_blank" ||
        link.hasAttribute("download")
      )
        return;
      const destination = new URL(link.href);
      if (
        destination.origin !== location.origin ||
        (destination.pathname === location.pathname && destination.hash)
      )
        return;
      event.preventDefault();
      if ((await save()) && !dirty()) location.assign(link.href);
      else
        toast(
          "Your notes are still unsaved. Keep this tab open and retry Save my notes.",
          "error",
        );
    },
    true,
  );
  document.addEventListener(
    "submit",
    async (event) => {
      if (event.target === form || !dirty()) return;
      event.preventDefault();
      event.stopImmediatePropagation();
      const target = event.target,
        button = event.submitter;
      if ((await save()) && !dirty()) target.requestSubmit(button);
      else toast("Save your notes before leaving this lesson.", "error");
    },
    true,
  );
}
const quizForm = document.querySelector("#quiz-form");
if (quizForm) {
  const questions = [...quizForm.querySelectorAll("[data-question]")];
  let index = 0;
  const next = quizForm.querySelector("[data-quiz-next]"),
    back = quizForm.querySelector("[data-quiz-prev]"),
    submit = quizForm.querySelector("[data-quiz-submit]");
  const update = () => {
    questions.forEach((q, i) => (q.hidden = i !== index));
    back.disabled = index === 0;
    next.hidden = index === questions.length - 1;
    submit.hidden = index !== questions.length - 1;
    quizForm.querySelector("[data-question-label]").textContent =
      `Question ${index + 1} of ${questions.length}`;
    quizForm.querySelector("[data-question-progress]").style.width =
      `${((index + 1) / questions.length) * 100}%`;
    quizForm.querySelectorAll("[data-question-dot]").forEach((d, i) => {
      d.classList.toggle("active", i === index);
      if (i === index) d.setAttribute("aria-current", "step");
      else d.removeAttribute("aria-current");
      d.classList.toggle(
        "answered",
        !!questions[i].querySelector(
          'input:checked, textarea[data-answered="true"]',
        ),
      );
    });
  };
  update();
  next.addEventListener("click", () => {
    index = Math.min(index + 1, questions.length - 1);
    update();
  });
  back.addEventListener("click", () => {
    index = Math.max(0, index - 1);
    update();
  });
  quizForm.querySelectorAll("[data-question-dot]").forEach((b, i) =>
    b.addEventListener("click", () => {
      index = i;
      update();
    }),
  );
  quizForm
    .querySelectorAll("textarea")
    .forEach((t) =>
      t.addEventListener(
        "input",
        () => (t.dataset.answered = String(!!t.value.trim())),
      ),
    );
  let sending = false;
  async function send(timedOut = false) {
    if (sending) return;
    if (
      !timedOut &&
      !(await confirmAction(
        "Ready to submit? Your answers cannot be changed after submission.",
        "Let’s see what’s clicking.",
      ))
    )
      return;
    sending = true;
    busy(submit, true);
    const answers = {};
    questions.forEach((q) => {
      const id = q.dataset.question;
      const text = q.querySelector("textarea");
      answers[id] = text
        ? text.value
        : [...q.querySelectorAll("input:checked")].map((i) => i.value);
    });
    try {
      handleSuccess(await api(quizForm.action, { answers }));
    } catch (e) {
      sending = false;
      busy(submit, false);
      showFormError(quizForm, e);
    }
  }
  quizForm.addEventListener("submit", (e) => {
    e.preventDefault();
    send();
  });
  if (quizForm.dataset.deadline) {
    const deadline = new Date(quizForm.dataset.deadline).getTime();
    const timer = document.querySelector("[data-quiz-timer]");
    const tick = () => {
      const seconds = Math.max(0, Math.floor((deadline - Date.now()) / 1000));
      if (timer)
        timer.textContent = `${Math.floor(seconds / 60)}:${String(seconds % 60).padStart(2, "0")} remaining`;
      if (seconds <= 0) {
        clearInterval(interval);
        send(true);
      }
    };
    const interval = setInterval(tick, 1000);
    tick();
  }
}
