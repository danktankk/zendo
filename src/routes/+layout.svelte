<script lang="ts">
  import '../app.css';  // your Tailwind entry
  let themeIsDark = false;

  // on first mount, mirror <html>’s class
  import { onMount } from 'svelte';
  onMount(() => {
    themeIsDark = document.documentElement.classList.contains('dark');
  });

  function toggleTheme() {
    themeIsDark = !themeIsDark;
    document.documentElement.classList.toggle('dark', themeIsDark);
    localStorage.setItem('theme', themeIsDark ? 'dark' : 'light');
  }
</script>

<button
  on:click={toggleTheme}
  class="fixed top-4 right-4 p-2 rounded bg-gray-200 dark:bg-gray-800"
>
  {themeIsDark ? '☀️ Light Mode' : '🌙 Dark Mode'}
</button>

{@render children()}
