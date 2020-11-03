import http from '../http-common'

class ClockDataService {
  get (id) {
    return http.get(`/clocks/${id}`)
  }

  create (id, data) {
    return http.post(`/clocks/${id}`, data)
  }
}

export default new ClockDataService()
