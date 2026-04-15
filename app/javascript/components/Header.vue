<template>
  <div class="navbar bg-base-100 shadow">
    <div class="flex-1">
      <Link href="/" class="btn btn-ghost text-xl">Medibook</Link>
    </div>

    <div class="flex-1 flex justify-center gap-6">
      <Link href="/" class="btn btn-ghost">Account</Link>
      <Link href="/doctors" class="btn btn-ghost">Doctors</Link>
      <Link href="/appointments" class="btn btn-ghost">Appointments</Link>
    </div>

    <div class="flex-1 flex justify-end gap-2">
      <div v-if="!user">
        <Link href="/login" class="btn btn-ghost">Login</Link>
        <Link href="/register" class="btn btn-primary">Register</Link>
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
import { usePage, Link } from '@inertiajs/vue3'
import { computed } from 'vue'
import axios from 'axios'

const user = computed(() => usePage().props?.user ?? null)
const logout = async () => {
  await axios.post('/auth/logout')

  window.location.href = '/login'
}
</script>
