import { BrowserRouter, Route, Routes } from "react-router-dom";
import Login from "./pages/Login";
import Home from "./pages/Home";
import Animachado from "./pages/Animachado";
import AlterarAnimachado from "./pages/AlterarAnimachado";
import CadastroAnimachado from "./pages/CadastroAnimachado";
import VisualizarAnimachado from "./pages/VisualizarAnimachado";
import Doador from "./pages/Doador";

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
            </Routes>
        </BrowserRouter>
    )
}