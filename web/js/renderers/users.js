"user strict";

import { parseHTML } from "/js/utils/parseHTML.js";

const usersRenderer = {
  asLine: function (user) {
    let html = `<p id="user-${user.userId}">
        <strong><span class="userId badge bg-secondary">${user.userId}</span></strong>  <span class="username">${user.username}</span>
    </p>`;
    return parseHTML(html);
  },
};

export { usersRenderer };
