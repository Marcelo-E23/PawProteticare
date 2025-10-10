import { Link } from 'react-router-dom'
import Header from '../../components/Header'
import styles from './home.module.css'
import animais from '../../image/animais.png'
import doadores from '../../image/doadores.png'
import adocao from '../../image/Adocao.png'
import protese from '../../image/Protese.png'

export default function Home(){
    return(
        <>
            <Header/> 
            <main>
                <Link to='/animachado'>
                    <div className={styles.card}>
                        <img src={animais} alt="Animail" />
                        <p>Animais</p>
                    </div>
                </Link>
                
                <Link to='/Doador'>
                    <div className={styles.card}>
                    <img src={doadores} alt="Doador" />
                    <p>Doadores</p>
                    </div>
                </Link>

                <Link to='/animachado'>
                    <div className={styles.card}>
                        <img src={protese} alt="Animail" />
                        <p>Protese</p>
                    </div>
                </Link>
                
                <Link to='/Doador'>
                    <div className={styles.card}>
                    <img src={adocao} alt="Doador" />
                    <p>Adoção</p>
                    </div>
                </Link>
            </main> 
         
        </>
    )
}