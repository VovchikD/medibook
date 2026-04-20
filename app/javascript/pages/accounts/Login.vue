<template>
  <div class="min-h-screen flex items-center justify-center">
    <div class="card w-96 bg-base-100 shadow-xl">
      <div class="card-body gap-3">
        <h2 class="card-title">Login</h2>

        <input
          v-model="form.email"
          type="email"
          placeholder="Email"
          class="input input-bordered"
        />

        <input
          v-model="form.password"
          type="password"
          placeholder="Password"
          class="input input-bordered"
        />

        <p v-if="form.errors.error" class="text-error text-sm">
          {{ form.errors.error }}
        </p>

        <button
          type="submit"
          class="btn btn-primary"
          @click="login"
        >
          Login
        </button>

        <p class="text-sm mt-2">
          No account?
          <a href="/register" class="link">Register</a>
        </p>
      </div>
    </div>
  </div>
</template>

<script setup>
import axios from '../../lib/axios'
import { reactive } from 'vue'

const form = reactive({
  email: '',
  password: '',
  errors: {}
})

const login = async () => {
  try {
    await axios.post('/auth/login', {
      email: form.email,
      password: form.password
    })

    window.location.href = '/'
  } catch (error) {
    form.errors.error = error.response?.data?.error
  }
}
</script>
