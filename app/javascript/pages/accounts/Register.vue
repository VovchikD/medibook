<template>
  <div class="min-h-screen flex items-center justify-center">
    <div class="card w-96 bg-base-100 shadow-xl">
      <div class="card-body">
        <h2 class="card-title">Register</h2>
        <input
          v-model="form.fullname"
          type="text"
          placeholder="Full name"
          class="input input-bordered"
        />

        <input
          v-model="form.phone"
          type="text"
          placeholder="Phone"
          class="input input-bordered"
        />

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
          class="btn btn-primary mt-2"
          @click="register"
        >
          Create account
        </button>

        <p class="text-sm mt-2">
          Already have an account?
          <a href="/login" class="link">Login</a>
        </p>
      </div>
    </div>
  </div>
</template>

<script setup>
import axios from 'axios'
import { reactive } from 'vue'

const form = reactive({
  email: '',
  password: '',
  fullname: '',
  phone: '',
  errors: {}
})


const register = async () => {
  try {
    await axios.post('/auth/create-account', {
      email: form.email,
      password: form.password,
      fullname: form.fullname,
      phone: form.phone
    })

    window.location.href = '/'
  } catch (error) {
    form.errors.error = error.response?.data?.error
  }
}
</script>
