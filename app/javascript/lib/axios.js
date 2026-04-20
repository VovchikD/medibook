import axios from 'axios'
import { toast } from 'vue3-toastify'
import 'vue3-toastify/dist/index.css'

axios.defaults.headers.common.Accept = 'application/json, text/plain, */*'
axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest'

axios.interceptors.response.use(
  (response) => response,
  (error) => {
    const status = error.response?.status
    const data = error.response?.data
    const message = data?.error || data?.message

    if (status === 403 && message) {
      toast.error(message)
    }

    return Promise.reject(error)
  }
)

export default axios
