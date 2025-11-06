import styles from './voltar.module.css'
import React from 'react';
import { useNavigate } from 'react-router-dom';


export default function Voltar(){
  const navigate = useNavigate();

  const voltar = () => {
    navigate(-1); 
  };
    return(
        <>
            <p onClick={voltar}className={styles.voltar}>Voltar</p>
        </>
    )

}