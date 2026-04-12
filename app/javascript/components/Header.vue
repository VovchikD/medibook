<template>
  <div class="navbar bg-base-100 shadow">
    <div class="flex-1">
      <a href="/" class="btn btn-ghost text-xl">Medibook</a>
    </div>

    <div class="flex-none gap-2">
      <div v-if="!user">
        <a href="/login" class="btn btn-ghost">Login</a>
        <a href="/register" class="btn btn-primary">Register</a>
      </div>

      <div v-else>
        <div class="dropdown dropdown-end">
          <div tabindex="0" role="button" class="btn btn-primary">
            {{ user.fullname }}
          </div>

          <ul
            tabindex="0"
            class="menu menu-sm dropdown-content mt-3 z-10 p-2 shadow bg-base-100 rounded-box w-52"
          >
            <li><span>{{ user.email }}</span></li>
            <li><span>{{ user.phone }}</span></li>
            <li>
              <a @click="logout">Logout</a>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { usePage } from '@inertiajs/vue3'
import { computed } from 'vue'
import axios from 'axios'

const user = computed(() => usePage().props?.user ?? null)
const logout = async () => {
  await axios.post('/auth/logout')

  window.location.href = '/login'
}
</script>
