  include('shared.lua') 
  
  ENT.RenderGroup = RENDERGROUP_BOTH
   
  /*---------------------------------------------------------
   Name: Draw
   Desc: Draw it!
  //-------------------------------------------------------*/
  function ENT:Draw()
   self:DrawModel()
  end
   
 