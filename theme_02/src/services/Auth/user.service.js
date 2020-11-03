import http from '../http-common'
import authHeader from './auth-header';

const API_URL = 'http://localhost:4000/api/auth/';

class UserService {
  getPublicContent() {
    return http.get('/all');
  }

  getUserBoard() {
    return http.get('/user', { headers: authHeader() });
  }

  getModeratorBoard() {
    return http.get('/mod', { headers: authHeader() });
  }

  getAdminBoard() {
    return http.get('/admin', { headers: authHeader() });
  }

  login() {
    return http.post('/login', data)
  }
}

export default new UserService();