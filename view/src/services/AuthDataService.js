import http from '../http-common'

class AuthDataService {
  login (data) {
    return http.post('/sign_in', data)
  }
  register (data) {
    return http.post('/sign_up', data)
  }
  getRole () {
    return http.get('/role')
  }
  addRole (data) {
    return http.post(`/role`, data)
  }
}

export default new AuthDataService()
