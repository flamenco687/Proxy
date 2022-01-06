"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[556],{52157:function(e,t,n){n.r(t),n.d(t,{frontMatter:function(){return r},contentTitle:function(){return o},metadata:function(){return u},toc:function(){return p},default:function(){return h}});var i=n(87462),a=n(63366),l=(n(67294),n(3905)),d=["components"],r={},o=void 0,u={type:"mdx",permalink:"/Proxy/CHANGELOG",source:"@site/pages/CHANGELOG.md"},p=[{value:"3.0.0 - 2022-05-01",id:"300---2022-05-01",children:[{value:"Added",id:"added",children:[]},{value:"Removed",id:"removed",children:[]},{value:"Changes",id:"changes",children:[]},{value:"Improvements",id:"improvements",children:[]},{value:"Fixed",id:"fixed",children:[]}]},{value:"2.1.4 - 2022-04-01",id:"214---2022-04-01",children:[{value:"Added",id:"added-1",children:[]}]},{value:"2.1.3 - 2022-03-01",id:"213---2022-03-01",children:[{value:"Fixed",id:"fixed-1",children:[]}]},{value:"2.1.2 - 2022-03-01",id:"212---2022-03-01",children:[{value:"Fixed",id:"fixed-2",children:[]}]},{value:"2.1.1 - 2022-03-01",id:"211---2022-03-01",children:[{value:"Fixed",id:"fixed-3",children:[]}]},{value:"2.1.0 - 2022-03-01",id:"210---2022-03-01",children:[{value:"Updated",id:"updated",children:[]},{value:"Added",id:"added-2",children:[]},{value:"Improvements",id:"improvements-1",children:[]},{value:"Fixed",id:"fixed-4",children:[]}]},{value:"2.0.2 - 2022-01-01",id:"202---2022-01-01",children:[{value:"Updated",id:"updated-1",children:[]},{value:"Changed",id:"changed",children:[]},{value:"Added",id:"added-3",children:[]},{value:"Fixed",id:"fixed-5",children:[]}]},{value:"2.0.1 - 2021-11-25",id:"201---2021-11-25",children:[{value:"Changed",id:"changed-1",children:[]}]}],s={toc:p};function h(e){var t=e.components,n=(0,a.Z)(e,d);return(0,l.kt)("wrapper",(0,i.Z)({},s,n,{components:t,mdxType:"MDXLayout"}),(0,l.kt)("h2",{id:"300---2022-05-01"},"[3.0.0]"," - 2022-05-01"),(0,l.kt)("h3",{id:"added"},"Added"),(0,l.kt)("ul",null,(0,l.kt)("li",{parentName:"ul"},(0,l.kt)("inlineCode",{parentName:"li"},":OnChange()")," in replacement of ",(0,l.kt)("inlineCode",{parentName:"li"},".Changed"),", directly connects the passed functions and can be disconnected by calling the returned function"),(0,l.kt)("li",{parentName:"ul"},(0,l.kt)("inlineCode",{parentName:"li"},":OnIndex()")," in replacement of ",(0,l.kt)("inlineCode",{parentName:"li"},".Indexed"),", directly connects the passed functions and can be disconnected by calling the returned function"),(0,l.kt)("li",{parentName:"ul"},(0,l.kt)("inlineCode",{parentName:"li"},":Set()")," and ",(0,l.kt)("inlineCode",{parentName:"li"},":Get()")," to interact with values inside the proxy table that are proxy properties or methods"),(0,l.kt)("li",{parentName:"ul"},"Better documentation and extra functions regarding the new connections system")),(0,l.kt)("h3",{id:"removed"},"Removed"),(0,l.kt)("ul",null,(0,l.kt)("li",{parentName:"ul"},"Signal dependency"),(0,l.kt)("li",{parentName:"ul"},"Proxies cannot longer inherit or convert other tables in proxies by default, that implementation must be done externally now to keep it simpler")),(0,l.kt)("h3",{id:"changes"},"Changes"),(0,l.kt)("ul",null,(0,l.kt)("li",{parentName:"ul"},"Overhauled most documentation"),(0,l.kt)("li",{parentName:"ul"},"Changed the way change or index listeners are handled as part of the Signal removal"),(0,l.kt)("li",{parentName:"ul"},"Proxy methods are stored inside a table to prevent conflicts with indexing")),(0,l.kt)("h3",{id:"improvements"},"Improvements"),(0,l.kt)("ul",null,(0,l.kt)("li",{parentName:"ul"},"When adding custom properties to a proxy, default proxy properties are protected and cannot be overriden. Trying to do so will throw a warning"),(0,l.kt)("li",{parentName:"ul"},"Simplified the code")),(0,l.kt)("h3",{id:"fixed"},"Fixed"),(0,l.kt)("ul",null,(0,l.kt)("li",{parentName:"ul"},"A lot of issues, in general. The module should have near to 0 bugs")),(0,l.kt)("h2",{id:"214---2022-04-01"},"[2.1.4]"," - 2022-04-01"),(0,l.kt)("h3",{id:"added-1"},"Added"),(0,l.kt)("ul",null,(0,l.kt)("li",{parentName:"ul"},(0,l.kt)("inlineCode",{parentName:"li"},"Indexed")," & ",(0,l.kt)("inlineCode",{parentName:"li"},"Changed")," now pass the proxy as a third argument")),(0,l.kt)("h2",{id:"213---2022-03-01"},"[2.1.3]"," - 2022-03-01"),(0,l.kt)("h3",{id:"fixed-1"},"Fixed"),(0,l.kt)("ul",null,(0,l.kt)("li",{parentName:"ul"},"Proxies didn't inherit parent's custom properties"),(0,l.kt)("li",{parentName:"ul"},(0,l.kt)("inlineCode",{parentName:"li"},"build")," folder (",(0,l.kt)("a",{parentName:"li",href:"https://upliftgames.github.io/moonwave/"},"Moonwave")," page) was being included inside the package installation, updated wally.toml exclude")),(0,l.kt)("h2",{id:"212---2022-03-01"},"[2.1.2]"," - 2022-03-01"),(0,l.kt)("h3",{id:"fixed-2"},"Fixed"),(0,l.kt)("ul",null,(0,l.kt)("li",{parentName:"ul"},"Constructor attempted to check the lenght of a nil value when checking if children proxies should inherit properties")),(0,l.kt)("h2",{id:"211---2022-03-01"},"[2.1.1]"," - 2022-03-01"),(0,l.kt)("h3",{id:"fixed-3"},"Fixed"),(0,l.kt)("ul",null,(0,l.kt)("li",{parentName:"ul"},"Fixed ",(0,l.kt)("inlineCode",{parentName:"li"},".new")," trying to iterate through CustomProperties even if it is nil"),(0,l.kt)("li",{parentName:"ul"},"Fixed passing default proxy properties as custom properties when constructing a new proxy from ",(0,l.kt)("inlineCode",{parentName:"li"},"__newindex")," ")),(0,l.kt)("h2",{id:"210---2022-03-01"},"[2.1.0]"," - 2022-03-01"),(0,l.kt)("p",null,(0,l.kt)("em",{parentName:"p"},"Since this version, the Proxy project uses the default tree structure of ",(0,l.kt)("inlineCode",{parentName:"em"},"src/init.lua")," so moonwave documentation can be generated with ease.")),(0,l.kt)("h3",{id:"updated"},"Updated"),(0,l.kt)("ul",null,(0,l.kt)("li",{parentName:"ul"},"StyLua: ","[0.11.2]"," -> ","[0.11.3]")),(0,l.kt)("h3",{id:"added-2"},"Added"),(0,l.kt)("ul",null,(0,l.kt)("li",{parentName:"ul"},(0,l.kt)("inlineCode",{parentName:"li"},"CustomProperties: table")," can now be passed as an argument when constructing proxies. It is the equivalent of manually adding custom properties to\nthe proxy by using ",(0,l.kt)("inlineCode",{parentName:"li"},"rawset"),", but passing the argument will ensure those properties are replicated to inherited proxies that are directly found in the\nproxy origin"),(0,l.kt)("li",{parentName:"ul"},"Missing type annotations")),(0,l.kt)("h3",{id:"improvements-1"},"Improvements"),(0,l.kt)("ul",null,(0,l.kt)("li",{parentName:"ul"},"Completed moonwave documentation"),(0,l.kt)("li",{parentName:"ul"},"Fixed some variables not using the new ",(0,l.kt)("a",{parentName:"li",href:"https://devforum.roblox.com/t/luau-recap-october-2021/1531825"},"if-then-else expression"))),(0,l.kt)("h3",{id:"fixed-4"},"Fixed"),(0,l.kt)("ul",null,(0,l.kt)("li",{parentName:"ul"},"Fixed optional types being required types when constructing a proxy"),(0,l.kt)("li",{parentName:"ul"},"Proxies only inherited properties when being newly added, but tables found inside the proxy origin were not converted to proxies, fixed that")),(0,l.kt)("h2",{id:"202---2022-01-01"},"[2.0.2]"," - 2022-01-01"),(0,l.kt)("p",null,(0,l.kt)("em",{parentName:"p"},"Happy new year!")),(0,l.kt)("h3",{id:"updated-1"},"Updated"),(0,l.kt)("ul",null,(0,l.kt)("li",{parentName:"ul"},"Selene: ","[0.14.0]"," -> ","[0.15.0]")),(0,l.kt)("h3",{id:"changed"},"Changed"),(0,l.kt)("ul",null,(0,l.kt)("li",{parentName:"ul"},(0,l.kt)("inlineCode",{parentName:"li"},"Proxy:Destroy()")," will now specifically return nil to comply with the type annotations"),(0,l.kt)("li",{parentName:"ul"},(0,l.kt)("inlineCode",{parentName:"li"},"Proxy:Destroy()")," will now set to nil the proxy's metatable"),(0,l.kt)("li",{parentName:"ul"},"Variable naming was updated to be all in PascalCase and stay accordingly with my personal style guide")),(0,l.kt)("h3",{id:"added-3"},"Added"),(0,l.kt)("ul",null,(0,l.kt)("li",{parentName:"ul"},"When creating a new proxy, you can optionally specify if child tables should automatically be converted to proxies (Inheritance). Additionally,\nif a proxy's key is set to nil and its value is a proxy table, it will automatically be destroyed with ",(0,l.kt)("inlineCode",{parentName:"li"},"Proxy:Destroy()")),(0,l.kt)("li",{parentName:"ul"},"New type added to represent itself the Proxy class")),(0,l.kt)("h3",{id:"fixed-5"},"Fixed"),(0,l.kt)("ul",null,(0,l.kt)("li",{parentName:"ul"},"Changed signal could fire even if the value was not actually changed to a new or different value")),(0,l.kt)("h2",{id:"201---2021-11-25"},"[2.0.1]"," - 2021-11-25"),(0,l.kt)("h3",{id:"changed-1"},"Changed"),(0,l.kt)("ul",null,(0,l.kt)("li",{parentName:"ul"},"Renamed ",(0,l.kt)("inlineCode",{parentName:"li"},":Kill()")," to ",(0,l.kt)("inlineCode",{parentName:"li"},":Destroy()")," for better consistency")))}h.isMDXComponent=!0}}]);