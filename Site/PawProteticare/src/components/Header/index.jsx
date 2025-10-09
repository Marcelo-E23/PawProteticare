import { Link } from 'react-router-dom'
import styles from './Header.module.css'
import logo from '../../image/logo.png'

export default function Header(){
    return(
        <header className={styles.header}>
            <img className={styles.logo}src={logo} alt="Logo PawProteticare" />
            <p className={styles.titulo}>PawProteticare</p>            <nav>
                <Link to='/Home'>Home</Link>
                <Link to="/">Sair</Link>
            </nav>
        </header>
    )

}

