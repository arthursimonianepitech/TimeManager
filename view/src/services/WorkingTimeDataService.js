import http from '../http-common'

class WorkingTimeDataService {
  getAll () {
    return http.get('/workingtimes')
  }

  get (userId, id) {
    return http.get(`/workingtimes/${userId}/${id}`)
  }

  create (userId, data) {
    return http.post(`/workingtimes/${userId}`, data)
  }

  update (id, data) {
    return http.put(`/workingtimes/${id}`, data)
  }

  delete (id) {
    return http.delete(`/workingtimes/${id}`)
  }
}

export default new WorkingTimeDataService()
