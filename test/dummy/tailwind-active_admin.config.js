import { execSync } from "child_process";
import { fileURLToPath } from "url";
import path from "path";
import activeAdminPlugin from "@activeadmin/activeadmin/plugin";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
process.env.BUNDLE_GEMFILE ||= path.resolve(__dirname, "../../Gemfile");

const bundleShow = (gem) =>
  execSync(`bundle show ${gem}`, { encoding: "utf-8", env: process.env })
    .trim()
    .split(/\r?\n/)
    .pop();

const activeAdminPath = bundleShow("activeadmin");
const themePath = bundleShow("activeadmin-claude-theme");

export default {
  content: [
    `${themePath}/app/views/**/*.{erb,html,arb,rb}`,
    `${activeAdminPath}/vendor/javascript/flowbite.js`,
    `${activeAdminPath}/plugin.js`,
    `${activeAdminPath}/app/views/**/*.{arb,erb,html,rb}`,
    "./app/admin/**/*.{arb,erb,html,rb}",
    "./app/views/active_admin/**/*.{arb,erb,html,rb}",
    "./app/views/admin/**/*.{arb,erb,html,rb}",
    "./app/views/layouts/active_admin*.{erb,html}",
    "./app/javascript/**/*.js",
  ],
  darkMode: "selector",
  plugins: [activeAdminPlugin],
};
