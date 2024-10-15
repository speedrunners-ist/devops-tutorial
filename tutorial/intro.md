# Learn about Piku and its features

## Motivation and Background

Nowadays, there are lots of tools that allow developers to effortlessly deploy applications.
Some of them are paid and managed by third party companies, while others are open-source and self-hosted.
Piku is a (self-called) tiny and open-source self-hosted Platform as a Service (PaaS) that allows you to deploy your applications with ease through the command line.
It shines in its simplicity and ease of use, combined with the ability to extend its functionalities with plugins:
you can, essentially, do `git push` deployments!

## Tutorial Overview + Objectives

In this tutorial, we will start by deploying a simple clojure application using Piku.
Then, we will tinker with some environment variables and redeploy the application.
Finally, we will create a custom plugin and use it.

By the end of this tutorial, you will be able to not only deploy your own personal projects using Piku,
but also get to know the core details about its under-the-hood implementation.
You will know more about what `Procfile` and `ENV` files are, understand
how to access a Piku app's logs, and how to add plugins to Piku applications.

![Piku Logo](./assets/logo.png)
