import { BrowserRouter, Route, Routes } from "react-router-dom";
import Login from "./pages/Login";
import Home from "./pages/Home";
import Animachado from "./pages/Animal/Animachado";
import AlterarAnimachado from "./pages/Animal/AlterarAnimachado";
import CadastroAnimachado from "./pages/Animal/CadastroAnimachado";
import VisualizarAnimachado from "./pages/Animal/VisualizarAnimachado";
import Doador from "./pages/Doador/Doador";
import Adocao from "./pages/Adocao/Adocao";


export default function AppRoutes(){
    return(
        <BrowserRouter>
            <Routes>
                <Route path="/" element={<Home/>}/>
                <Route path="/Home" element={<Home/>}/>
                <Route path="/Animachado" element={<Animachado/>}/>
                <Route path="/AlterarAnimachado/:id" element={<AlterarAnimachado/>}/>
                <Route path="/CadastroAnimachado" element={<CadastroAnimachado/>}/>
                <Route path="/VisualizarAnimachado/:id" element={<VisualizarAnimachado/>}/>
                <Route path="/Doador" element={<Doador/>}/>
                <Route path="/Adocao" element={<Adocao/>}/>
            </Routes>
        </BrowserRouter>
    )
}