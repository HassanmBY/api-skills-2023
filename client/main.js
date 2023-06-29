"use strict";

const formElem = document.querySelector(".form");
const url = "http://localhost/api-2023/";

let token;
fetch(`${url}auth`, {
	method: "POST",
	headers: {
		"Content-Type": "application/json",
	},
	body: JSON.stringify({
		login: "admin",
		password: "admin",
		auth: "",
	}),
})
	.then(response => response.json())
	.then(data => {
		token = data.token;
	})
	.catch(error => console.error(error));

fetch(`${url}contacts`)
	.then(response => response.json())
	.then(data => {
		let contacts = data.content;
		for (const contact of contacts) {
			const li = document.createElement("li");
			const input = document.createElement("input");
			input.type = "checkbox";
			input.value = contact.id;
			input.name = "contact";
			li.textContent = `${contact.name} ${contact.firstname}`; /*(${contact.email})*/
			li.appendChild(input);
			document.querySelector("ul").appendChild(li);
		}
	});

formElem.addEventListener("submit", e => {
	e.preventDefault();
	let formData = new FormData(formElem);
	let sentObject = {
		token: token,
		delete: formData.getAll("contact"),
	};
	fetch(`${url}contacts`, {
		method: "DELETE",
		headers: {
			"Content-Type": "application/json",
		},
		body: JSON.stringify(sentObject),
	})
		.then(response => response.json())
		.then(data => {
			console.log(data);
		})
		.catch(error => console.error(error));
	setTimeout(() => {
		window.location.reload();
	});
});
