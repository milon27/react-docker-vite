import axios from 'axios'
import { startOfToday } from 'date-fns'

axios.defaults.baseURL = import.meta.env.VITE_APP_API + ''

function App() {

  return (
    <div className="App">
      load from env: {import.meta.env.VITE_APP_API}
      <br />
      Today is: {startOfToday().toLocaleString()} from date-fns library
    </div>
  )
}

export default App
