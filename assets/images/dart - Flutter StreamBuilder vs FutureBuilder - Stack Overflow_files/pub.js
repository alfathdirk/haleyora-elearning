/* HouseHold ImplementationValidator LegacyLayer SignalsAutoInsertion SignalsIds */
(()=>{var Rt=Object.defineProperty,le=Object.defineProperties,ce=Object.getOwnPropertyDescriptor,ue=Object.getOwnPropertyDescriptors;var qt=Object.getOwnPropertySymbols;var de=Object.prototype.hasOwnProperty,pe=Object.prototype.propertyIsEnumerable;var _t=(o,t,e)=>t in o?Rt(o,t,{enumerable:!0,configurable:!0,writable:!0,value:e}):o[t]=e,Q=(o,t)=>{for(var e in t||(t={}))de.call(t,e)&&_t(o,e,t[e]);if(qt)for(var e of qt(t))pe.call(t,e)&&_t(o,e,t[e]);return o},W=(o,t)=>le(o,ue(t)),i=(o,t)=>Rt(o,"name",{value:t,configurable:!0});var a=(o,t,e,r)=>{for(var n=r>1?void 0:r?ce(t,e):t,s=o.length-1,g;s>=0;s--)(g=o[s])&&(n=(r?g(t,e,n):g(n))||n);return r&&n&&Rt(t,e,n),n};var l=(o,t,e)=>(_t(o,typeof t!="symbol"?t+"":t,e),e);var S=(o,t,e)=>new Promise((r,n)=>{var s=h=>{try{u(e.next(h))}catch(f){n(f)}},g=h=>{try{u(e.throw(h))}catch(f){n(f)}},u=h=>h.done?r(h.value):Promise.resolve(h.value).then(s,g);u((e=e.apply(o,t)).next())});var Et={queueAdRequest:o=>{var t;try{(t=o.callback)==null||t.call(o),o.callback=null}catch(e){}},defineSlot:(o,t)=>{},getTargeting:o=>({})};var bt=class bt{constructor(){l(this,"isEntryModule",!0)}};i(bt,"EntryModule");var L=bt;var lt=class lt{constructor(t){l(this,"_error");l(this,"_message","unknown");l(this,"_trace",[]);if(t instanceof lt)return t;t instanceof Error&&(this._error=t,this._message=t.message)}get error(){return this._error}get message(){return this._message}get trace(){return this._trace}addToTrace(t){this.trace.unshift(t)}};i(lt,"TracedError");var X=lt;var At=class At{constructor(t,e){l(this,"window");l(this,"dvtag");l(this,"modules",new Map);l(this,"errorHandlers",[]);l(this,"errors",[]);var r;this.window=e,this.window.dvtag=(r=this.window.dvtag)!=null?r:{},this.dvtag=this.window.dvtag,this.dvtag._core=this;for(let[n,s]of Object.entries(Et))this.dvtag[n]=s;for(let n of t)this.createModule(n);for(let n of this.modules.values())this.applyModuleDecoration(n);for(let n of this.modules.values())this.applyErrorDecoration(n);for(let n of this.modules.values())this.applyPluginDecoration(n);for(let n of this.modules.values())this.applyApiDecoration(n);for(let n of this.modules.values())this.applyExecuteDecoration(n)}get moduleList(){return[...this.modules.keys()].map(t=>t.name)}get entryModuleList(){return[...this.modules.entries()].filter(([t,e])=>e instanceof L).map(([t,e])=>t.name)}get(t){return this.getModule(t).gateway}getByName(t){let e=[...this.modules.keys()].find(r=>r.name===t);return e!=null?this.get(e):null}getModule(t){let e=this.modules.get(t);if(e==null)throw new Error(`module not in core: ${t.name}`);return e}createModule(t){if(t.prototype.moduleConfig==null)throw new Error(`not a module: ${t.name}`);let e=new t;e.core=this,e.gateway={module:e},this.modules.set(t,e)}applyModuleDecoration(t){var n,s,g,u,h,f;let e=t.constructor.prototype.moduleConfig,r=t.constructor.name;for(let{method:m}of e){let tt=t[m].bind(t),Y=(g=(s=(n=this.dvtag._hooks)==null?void 0:n.interceptModule)==null?void 0:s[r])==null?void 0:g[m],U=Y==null?tt:Y.bind(t),F=(f=(h=(u=this.dvtag._hooks)==null?void 0:u.inspectModule)==null?void 0:h[r])==null?void 0:f[m],yt=F==null?U:(...et)=>{let H=U(...et);return F(et,H),H},ge=i((...et)=>{let H;try{H=yt(...et)}catch(it){throw this.traceMethodError(t,m,et,it)}return H instanceof Promise?H.then(it=>it,it=>{throw this.traceMethodError(t,m,et,it)}):H},"traced");t.gateway[m]=ge}if(t.plugins!=null){t.pluginFunctions={};for(let m of Object.keys(t.plugins)){t.pluginFunctions[m]=[];let tt=t.pluginFunctions[m];t.plugins[m]=(...Y)=>{let U=[];for(let F of tt)try{U.push(F(...Y))}catch(yt){this.tracePluginError(t,m,yt)}return U}}}}traceMethodError(t,e,r,n){let s=new X(n);return s.addToTrace(`${t.constructor.name}.${e}(${r.map(g=>typeof g).join(",")})`),s}traceExecuteError(t){let e=new X(t);return e.addToTrace("@execute"),this.handleSevereError(e),e}tracePluginError(t,e,r){let n=new X(r);return n.addToTrace(`@plugin(${t.constructor.name}, '${e}')`),this.handleSevereError(n),n}traceApiError(t,e){let r=new X(e);return r.addToTrace(`@api('${t}')`),this.handleSevereError(r),r}handleSevereError(t){for(let e of this.errorHandlers)try{e(t)}catch(r){}this.errors.length>10||this.errors.push({message:t.message,trace:t.trace})}applyErrorDecoration(t){var r;let e=(r=t.constructor.prototype.errorConfig)!=null?r:[];for(let{method:n}of e)this.errorHandlers.push(t.gateway[n])}applyPluginDecoration(t){var r;let e=(r=t.constructor.prototype.pluginConfig)!=null?r:[];for(let{PluggableClass:n,category:s,method:g}of e)this.getModule(n).pluginFunctions[s].push(t.gateway[g])}applyApiDecoration(t){var r;let e=(r=t.constructor.prototype.apiConfig)!=null?r:[];for(let{api:n,method:s}of e)Object.defineProperty(this.dvtag,n,{value:(...g)=>{var u,h;try{return t.gateway[s](...g)}catch(f){return this.traceApiError(n,f),(h=(u=Et)[n])==null?void 0:h.call(u,...g)}},writable:!1})}applyExecuteDecoration(t){return S(this,null,function*(){var r;let e=(r=t.constructor.prototype.executeConfig)!=null?r:[];for(let{method:n}of e)try{yield t.gateway[n]()}catch(s){this.traceExecuteError(s)}})}};i(At,"Core");var st=At;var vt=[],Ut=vt;var d=i(o=>{let t=o.prototype,e=Object.getOwnPropertyNames(t).filter(r=>{var n;return r!=="constructor"&&((n=Object.getOwnPropertyDescriptor(t,r))==null?void 0:n.value)instanceof Function});t.moduleConfig=e.map(r=>({method:r})),vt.push(o)},"moduleClass"),j=i(o=>t=>{},"attachModule"),v=i((o,t)=>{var e;o.executeConfig=(e=o.executeConfig)!=null?e:[],o.executeConfig.push({method:t})},"executeMethod"),y=i((o,t)=>(e,r)=>{var n;e.pluginConfig=(n=e.pluginConfig)!=null?n:[],e.pluginConfig.push({PluggableClass:o,category:t,method:r})},"pluginMethod"),J=i(o=>(t,e)=>{var r;t.apiConfig=(r=t.apiConfig)!=null?r:[],t.apiConfig.push({api:o,method:e})},"apiMethod"),Mt=i((o,t)=>{var e;o.errorConfig=(e=o.errorConfig)!=null?e:[],o.errorConfig.push({method:t})},"errorMethod");var rt=i(o=>{if(o==null)return[];let t=Bt(o);return t!=null?[t]:Array.isArray(o)?o.map(Bt).filter(e=>e!=null):[]},"parseSlotSizes"),Bt=i(o=>{if(o==null)return null;if(typeof o=="string")return{label:o};if(Array.isArray(o)){if(o.length===1&&typeof o[0]=="string")return{label:o[0]};if(o.length===2&&typeof o[0]=="number"&&typeof o[1]=="number")return{width:o[0],height:o[1]}}if(typeof o=="object"){let{label:t,width:e,height:r}=o;if(typeof e=="number"&&typeof r=="number")return{width:e,height:r};if(typeof t=="string")return{label:t}}return null},"parseSlotSize");var It=i(o=>{try{return o.getSizes()}catch(t){return[]}},"getGptSlotSize");var he="dvp_spos",ct=i(o=>({id:o.getAdUnitPath(),sizes:rt(It(o)),position:o.getTargeting(he)[0]}),"gptSlotToAdUnit");var ut=i((o,t)=>({getTargeting:e=>[...new Set([...t(e),...o.getTargeting(e)])],setTargeting:(e,r)=>{o.setTargeting(e,r)}}),"gptSlotToTargetable");var dt,me=new Uint8Array(16);function Pt(){if(!dt&&(dt=typeof crypto!="undefined"&&crypto.getRandomValues&&crypto.getRandomValues.bind(crypto),!dt))throw new Error("crypto.getRandomValues() not supported. See https://github.com/uuidjs/uuid#getrandomvalues-not-supported");return dt(me)}i(Pt,"rng");var b=[];for(let o=0;o<256;++o)b.push((o+256).toString(16).slice(1));function Gt(o,t=0){return b[o[t+0]]+b[o[t+1]]+b[o[t+2]]+b[o[t+3]]+"-"+b[o[t+4]]+b[o[t+5]]+"-"+b[o[t+6]]+b[o[t+7]]+"-"+b[o[t+8]]+b[o[t+9]]+"-"+b[o[t+10]]+b[o[t+11]]+b[o[t+12]]+b[o[t+13]]+b[o[t+14]]+b[o[t+15]]}i(Gt,"unsafeStringify");var fe=typeof crypto!="undefined"&&crypto.randomUUID&&crypto.randomUUID.bind(crypto),xt={randomUUID:fe};function Se(o,t,e){if(xt.randomUUID&&!t&&!o)return xt.randomUUID();o=o||{};let r=o.random||(o.rng||Pt)();if(r[6]=r[6]&15|64,r[8]=r[8]&63|128,t){e=e||0;for(let n=0;n<16;++n)t[e+n]=r[n];return t}return Gt(r)}i(Se,"v4");var wt=Se;var nt=i(()=>wt(),"uuid");var Dt=class Dt{constructor(t,e,r,n,s){this._slotStore=t;this.source=e;this.elementId=r;this.adUnit=n;this._targetable=s;l(this,"uuid");l(this,"_variables",{});l(this,"_targeting",{});l(this,"_flushedTargeting",{});this.uuid=nt()}setVariable(t,e){this._variables[t]=e}getVariable(t){return this._variables[t]}getUptTargetingKeys(){return[...new Set([...Object.keys(this._targeting),...this._slotStore.getUptPageTargetingKeys()])]}getUptTargetingForKey(t){var e;return[...new Set([...(e=this._targeting[t])!=null?e:[],...this._slotStore.getUptPageTargetingForKey(t)])]}getUptTargeting(){let t={};for(let e of this.getUptTargetingKeys())t[e]=this.getUptTargetingForKey(e);return t}setUptSlotTargeting(t){for(let[e,r]of Object.entries(t))this._targeting[e]=[...new Set(r)],this.flushUptTargetingToAdServer(e)}addUptSlotTargeting(t){var e;for(let[r,n]of Object.entries(t))this._targeting[r]=[...new Set([...(e=this._targeting[r])!=null?e:[],...n])],this.flushUptTargetingToAdServer(r)}getAdServerTargeting(t){var e;return(e=this._targetable.getTargeting(t))!=null?e:[]}flushUptTargetingToAdServer(t){var n;let e=(n=this._flushedTargeting[t])!=null?n:[],r=this.getUptTargetingForKey(t);(e.length!==r.length||r.sort().some((s,g)=>e[g]!==s))&&(this._targetable.setTargeting(t,this.getUptTargetingForKey(t)),this._flushedTargeting[t]=r)}validateAdServerTargeting(){let t=2;for(let e of this.getUptTargetingKeys()){let r=this.getUptTargetingForKey(e),n=this.getAdServerTargeting(e);if(r.length>n.length||r.some(s=>!n.includes(s)))return 0;n.length>r.length&&(t=1)}return t}};i(Dt,"Slot");var at=Dt;var Te={getTargeting:()=>[],setTargeting:()=>{}},T=class{constructor(){l(this,"plugins",{slotScanned:(t,e)=>[],slotDiscovered:t=>[],slotRequested:(t,e)=>[],slotDestroyed:t=>[]});l(this,"_slots",{});l(this,"_pageTargeting",{})}getSlot(t,e){var r;return(r=this._slots[t])==null?void 0:r[e]}getSlots(t){var e;return t==null?Object.values(this._slots).flatMap(r=>Object.values(r)):Object.values((e=this._slots[t])!=null?e:{})}createSlot(t,e,r,n=Te){var u,h;let s=this.getSlot(t,e);s!=null&&this.plugins.slotDestroyed(s);let g=new at(this,t,e,r,n);(h=(u=this._slots)[t])!=null||(u[t]={}),this._slots[t][e]=g;for(let f of Object.keys(this._pageTargeting))g.flushUptTargetingToAdServer(f);return this.plugins.slotDiscovered(g),g}notifySlotScanned(t,e){this.plugins.slotScanned(t,e)}notifyAdRequested(t,e){this.plugins.slotRequested(t,e)}getUptPageTargetingKeys(){return Object.keys(this._pageTargeting)}getUptPageTargetingForKey(t){var e;return(e=this._pageTargeting[t])!=null?e:[]}getUptPageTargeting(){let t={};for(let[e,r]of Object.entries(this._pageTargeting))t[e]=[...r];return t}setUptPageTargeting(t){for(let[e,r]of Object.entries(t))this._pageTargeting[e]=[...new Set(r)];this._flushUptPageTargetingToAdServer(Object.keys(t))}addUptPageTargeting(t){var e;for(let[r,n]of Object.entries(t))this._pageTargeting[r]=[...new Set([...(e=this._pageTargeting[r])!=null?e:[],...n])];this._flushUptPageTargetingToAdServer(Object.keys(t))}_flushUptPageTargetingToAdServer(t){for(let e of Object.values(this._slots))for(let r of Object.values(e))for(let n of t)r==null||r.flushUptTargetingToAdServer(n)}};i(T,"SlotStore"),T=a([d],T);var Ct=class Ct{constructor(){l(this,"pending",[]);l(this,"flushing",!1)}push(t){this.pending.push(t),this.flush()}flush(){return S(this,null,function*(){var e;if(this.flushing)return;this.flushing=!0;let t=this.pending.shift();for(;t!=null;){try{yield t.promise}catch(r){}try{(e=t.callback)==null||e.call(t)}catch(r){}t=this.pending.shift()}this.flushing=!1})}};i(Ct,"AsyncQueue");var pt=Ct;var _=class{constructor(){l(this,"plugins",{adRequestQueued:t=>[],adRequestCompleted:t=>[]});l(this,"queue",new pt);l(this,"adRequestCounter",0)}_queueAdRequest(t={}){var s,g;let e={index:this.adRequestCounter++,status:"queued",timeoutValue:(s=t.timeout)!=null?s:0,onDvtagReadyCalled:(g=t.timestamp)!=null?g:0,waitingStarted:new Date().getTime(),internal:t.internal};this.plugins.adRequestQueued(e);let r=t.callback;r===void 0?e.status="no-callback":r===null?e.status="tag-timeout":t.callback=()=>{e.status="queue-timeout",e.callbackCalled=new Date().getTime(),t.callback=null;try{r()}catch(u){}};let n=i(()=>{if(t.callback!=null){t.callback=null,e.status="success",e.callbackCalled=new Date().getTime();try{r==null||r()}catch(u){}}e.waitingEnded=new Date().getTime(),this.plugins.adRequestCompleted(e)},"onAsyncOperationsCompleted");this.queue.push({callback:n})}delayAdRequests(t){this.queue.push({promise:t})}};i(_,"AdRequestQueue"),a([J("queueAdRequest")],_.prototype,"_queueAdRequest",1),_=a([d],_);var ye=[[/((\?)|&)(?:amp_lite|fr=operanews)/g,"$2"],[/(^https?:\/\/)(www\.)/g,"$1"],[/(((\?)|&|%3F|%26|;)(?:utm_campaign|utm_source|utm_content|utm_term|utm_viral|utm_medium|utm_identifier|utm_key|fb_source|referrer|referer|ref|rand|rnd|randid|\.?rand|\.?partner|cb|count|adid|session|sessionid|session_redirect|param\d|userinfo|uid|refresh|ocid|ncid|clickenc|fbclid|amp_js_v|amp_gsa|ns_source|ns_campaign|ns_mchanel|ns_mchannel|ns_linkname|ns_fee|src|ex_cid|usqp|source|xid|trkid|utm_social-type|mbid|utm_brand|__twitter_impression|utm_referrer|CMP|cmp|_cmp|cq_cmp)=[^&]*)/g,"$3"],[/[/.]amp(?:\/[?&]*)?$/g,""],[/((\?)|&)(?:outputType|isFollow|suppressMediaBar|cid|ICID|icid|bdk|wtu_id_h|utm_placement|intcmp|_native_ads|traffic_source|entry|\.tsrc|autoplay|autostart|dc_data|influencer|pubdate|utm_hp_ref|redirect|service|refresh_ce|refresh_cens|xcmg|target_id|_amp)=[^&]*/g,"$2"],[/(\?|&)(?:amp)(?:&|$|=[^&]*)/g,"$1"]],_e=[[/(?:\/|\/\?|\?|&|\/\$0|#[\s\S]*)+$/g,""],[/(?:\/|\/\?|\?|&|\/\$0|#[\s\S]*)+$/g,""]],Ft=i((o,t)=>{for(let[e,r]of o)t=t.replace(e,r);return t},"replaceByRules"),Qt=i(o=>{let t=Ft(ye,o);return Ft(_e,t)},"normalizeUrl");var jt=i(o=>o.split("?",1)[0].split("#",1)[0],"stripUrlQuery");var zt=i((o,t)=>{try{let e=new URLSearchParams(o),r=e.get("ctx"),n=e.get("cmp");if(r!=null&&n!=null)return{ctx:r,cmp:n,prefetch:t,legacy:!0}}catch(e){}return null},"parseInfo"),Kt=i(o=>{var t;return o.pathname!=="/signals/pub.js"?null:(t=zt(o.search,!0))!=null?t:zt(o.hash.substring(1),!1)},"parseLegacyPagetagUrl");var Re=/^\/dvtag\/([^/]+)\/([^/]+)\/pub\.js$/,A=class{constructor(){l(this,"visitUuid",nt());l(this,"tagInfo");l(this,"normalizedUrl")}_initialize(){this.getTagInfo()}getTagInfo(){var t;if(this.tagInfo==null){try{this.tagInfo=this._parseTagInfo()}catch(e){}(t=this.tagInfo)!=null||(this.tagInfo={ctx:"unknown",cmp:"unknown"})}return this.tagInfo}getVisitUuid(){return this.visitUuid}_parseTagInfo(){let t=this.getCurrentScriptSrc();if(t==null)return null;let e=new URL(t,"https://pub.doubleverify.com"),r=e.pathname,n=Re.exec(r);if(n!=null){let[,s,g]=n;return{ctx:s,cmp:g}}return Kt(e)}getCurrentScriptSrc(){var t,e;return(e=(t=this.core.window.document.currentScript)==null?void 0:t.getAttribute("src"))!=null?e:null}getStrippedPageUrl(){return jt(this.core.window.location.href)}getNormalizedPageUrl(){var e;let t=this.getStrippedPageUrl();return((e=this.normalizedUrl)==null?void 0:e.stripped)!==t&&(this.normalizedUrl={stripped:t,normalized:Qt(this.core.window.location.href)}),this.normalizedUrl.normalized}};i(A,"Context"),a([v],A.prototype,"_initialize",1),A=a([d],A);var N=class{getShortCommitId(){return"c0e7bc2"}getBuildTimestamp(){return 1711137613423}getAuthToken(){return"sX+bcSDBRUWNiQQ1abvTmpCxF3DOIJlgBimVr5PUA9C1YvqpZ+nSv06iqmzbheNd3pwx8W64nLHpgtS/eoY6+WInuAYRryIFk0OcSGTpaNbr4QPRxWPmbtFf09CY/Tc="}};i(N,"DefinedVariables"),N=a([d],N);var D=class{constructor(){l(this,"cache",{})}_performFetchJson(t,e){return S(this,null,function*(){let r=t;if(e!=null&&e.authToken){let g=this.core.get(N).getAuthToken(),u=new URL(t);u.searchParams.set("token",g),r=u.href}let n=yield this.core.window.fetch(r);return{json:yield n.json(),headers:n.headers}})}fetchJson(t,e){return S(this,null,function*(){let r=this.cache[t];return r==null&&(r=this._performFetchJson(t,e).then(n=>n.json),this.cache[t]=r),r})}};i(D,"Fetch"),D=a([d],D);var ht=["BSC","ABS"],Vt=["IDS"],mt=["VLP","TVP"],Ee=[...ht,...Vt,...mt],$t=i(o=>Ee.includes(o.toUpperCase()),"isSignal"),Yt=i(o=>mt.includes(o.toUpperCase()),"isSlotSignal"),Ht=i(o=>Vt.includes(o.toUpperCase()),"isUserSignal"),Wt=i(o=>ht.includes(o.toUpperCase()),"isPageSignal");var ft=i(o=>o==null?"":`@${o}`,"getPositionSuffix");var be=/^(\d+)x(\d+)$/,Xt=i(o=>o==="all"?[]:o.split(",").map(t=>{let e=t.match(be);return e==null?{label:t}:{width:parseInt(e[1],10),height:parseInt(e[2],10)}}),"stringToSlotSizes"),kt=i(o=>o.length===0?"all":o.map(({width:t,height:e,label:r})=>r!=null?r:`${t}x${e}`).join(","),"slotSizesToString"),Jt=i(o=>o==null?"":o.length>0&&o.every(({label:r})=>r==null)?kt(o):"","slotSizesToStringIfSpecific");var Ae="https://pub.doubleverify.com/dvtag/signals/",C=class{_getBaseUrl(t){let e=this.core.get(A),{ctx:r,cmp:n}=e.getTagInfo(),s=e.getNormalizedPageUrl();try{s=new URL(s).origin}catch(u){}let g=new URL(t,Ae);return g.searchParams.set("ctx",r),g.searchParams.set("cmp",n),g.searchParams.set("url",s),g}getUserTargetingUrl(t){let e=this._getBaseUrl("ids/pub.json");return t.includes("IDS")&&e.searchParams.set("ids","1"),e.href}getPageTargetingUrl(t,e){let r=this._getBaseUrl("bsc/pub.json");return r.searchParams.set("url",e),t.includes("BSC")&&r.searchParams.set("bsc","1"),t.includes("ABS")&&r.searchParams.set("abs","1"),r.href}getSlotTargetingUrl(t,e){var s;let r=this._getBaseUrl("vlp/pub.json");t.includes("VLP")&&r.searchParams.set("vlp","1"),t.includes("TVP")&&r.searchParams.set("tvp","1");let n=0;for(let g of e){let{id:u,position:h,sizes:f}=(s=g.adUnit)!=null?s:{},m=u+ft(h);r.searchParams.set(`slot-${n++}-${m}`,Jt(f))}return r.href}};i(C,"SignalsUrlBuilder"),C=a([d],C);var z=class{constructor(){l(this,"cache",{})}_fetchFreshSignals(t,e){return S(this,null,function*(){if(!e.some(Wt))return{};let r=this.core.get(C).getPageTargetingUrl(e,t),n;try{n=yield this.core.get(D).fetchJson(r,{authToken:!0})}catch(s){return{}}return n instanceof Object?n:{}})}fetchSignals(t,e=3){return S(this,null,function*(){let r=this.core.get(A),n=r.getNormalizedPageUrl(),s=r.getStrippedPageUrl();this.cache[s]==null&&(this.cache[s]=this._fetchFreshSignals(n,t));let g=yield this.cache[s];return this.core.get(A).getStrippedPageUrl()!==s&&e>0?this.fetchSignals(t,e-1):g})}};i(z,"PageSignals"),z=a([d],z);var K=class{constructor(){l(this,"cache",{});l(this,"pendingSlots",[]);l(this,"pendingBulkRequest",null)}_scheduleBulkRequest(t){return S(this,null,function*(){yield Promise.resolve();let e=this.core.get(C).getSlotTargetingUrl(t,this.pendingSlots);this.pendingSlots=[],this.pendingBulkRequest=null;let r;try{r=yield this.core.get(D).fetchJson(e,{authToken:!0})}catch(n){return[]}return r})}_fetchFreshSignals(t,e){return S(this,null,function*(){if(!e.some(Yt))return{};let r=this.pendingSlots.push(t)-1;this.pendingBulkRequest==null&&(this.pendingBulkRequest=this._scheduleBulkRequest(e));let s=(yield this.pendingBulkRequest)[r];return s instanceof Object?s:{}})}_getCacheKey(t){var u,h;let{id:e,position:r,sizes:n}=(u=t.adUnit)!=null?u:{},s=e+ft(r),g=(h=n==null?void 0:n.map(f=>{var m;return(m=f.label)!=null?m:`${f.width}x${f.height}`}).sort().join(","))!=null?h:"";return`${s}#${g}`}fetchSignals(t,e){return S(this,null,function*(){let r=this._getCacheKey(t);return this.cache[r]==null&&(this.cache[r]=this._fetchFreshSignals(t,e)),this.cache[r]})}};i(K,"SlotSignals"),K=a([d],K);var V=class{constructor(){l(this,"cache")}_fetchFreshSignals(t){return S(this,null,function*(){if(!t.some(Ht))return{};let e=this.core.get(C).getUserTargetingUrl(t),r;try{r=yield this.core.get(D).fetchJson(e,{authToken:!0})}catch(n){return{}}return r instanceof Object?r:{}})}fetchSignals(t){return S(this,null,function*(){return this.cache==null&&(this.cache=this._fetchFreshSignals(t)),this.cache})}};i(V,"UserSignals"),V=a([d],V);var R=class{constructor(){l(this,"plugins",{getEnabledSignals:()=>[],userTargetingUpdated:t=>[],pageTargetingUpdated:t=>[],slotTargetingUpdated:(t,e)=>[]});l(this,"dataForMigrationTracking",{userTargeting:{},pageTargeting:{},slotTargeting:new Map})}getEnabledSignals(){return this.plugins.getEnabledSignals()}getDataForMigrationTracking(){return this.dataForMigrationTracking}_initialize(){this.getUserTargeting(),this.getPageTargeting()}_onAdRequestQueued(){this.getPageTargeting()}_onSlotDiscovered(t){this.getSlotTargeting(t)}getUserTargeting(){return S(this,null,function*(){let t=this._fetchUserTargeting();return this.core.get(_).delayAdRequests(t),t})}getPageTargeting(){return S(this,null,function*(){let t=this._fetchPageTargeting();return this.core.get(_).delayAdRequests(t),t})}getSlotTargeting(t){return S(this,null,function*(){let e=this._fetchSlotTargeting(t);return this.core.get(_).delayAdRequests(e),e})}_fetchUserTargeting(){return S(this,null,function*(){let t=this.core.get(T),e=yield this.core.get(V).fetchSignals(this.getEnabledSignals());return t.setUptPageTargeting(e),this.dataForMigrationTracking.userTargeting=e,this.plugins.userTargetingUpdated(e),e})}_fetchPageTargeting(){return S(this,null,function*(){let t=this.core.get(T),e=yield this.core.get(z).fetchSignals(this.getEnabledSignals());return t.setUptPageTargeting(e),this.dataForMigrationTracking.pageTargeting=e,this.plugins.pageTargetingUpdated(e),e})}_fetchSlotTargeting(t){return S(this,null,function*(){let e=yield this.core.get(K).fetchSignals(t,this.getEnabledSignals());return t.setUptSlotTargeting(e),this.dataForMigrationTracking.slotTargeting.set(t,e),this.plugins.slotTargetingUpdated(t,e),e})}};i(R,"Signals"),a([v],R.prototype,"_initialize",1),a([y(_,"adRequestQueued")],R.prototype,"_onAdRequestQueued",1),a([y(T,"slotDiscovered")],R.prototype,"_onSlotDiscovered",1),R=a([d],R);var k=class{constructor(){l(this,"pq",null)}getPq(){return this.pq==null&&(this.pq=this._initialize()),this.pq}getPts(){return this.getPq().PTS}setApi(t){let e=this.getPq();e!=null&&(e.init=()=>{},e.loadSignals=t.loadSignals,e.loadSignalsForSlots=t.loadSignalsForSlots,e.getTargeting=t.getTargeting)}_pushToDvtagCmd(...t){var e;this.core.dvtag.cmd=(e=this.core.dvtag.cmd)!=null?e:[],this.core.dvtag.cmd.push(...t)}_initialize(){var r,n;this.core.window.PQ=(r=this.core.window.PQ)!=null?r:{};let t=this.core.window.PQ;if(t.loaded)return{cmd:[],PTS:{}};t.loaded=!0,t.PTS=(n=t.PTS)!=null?n:{};let e=t.cmd;return t.cmd={push:s=>this._pushToDvtagCmd(s)},Array.isArray(e)&&this._pushToDvtagCmd(...e),t}};i(k,"LegacyPq"),k=a([d],k);var te=i(o=>{var r,n,s;let t=nt(),e={id:(n=(r=o.adUnitPath)!=null?r:o.invCode)!=null?n:o.tagId,sizes:rt(Xt((s=o.sizes)!=null?s:"all")),position:o.position};return{elementId:t,adUnit:e}},"parseLegacyAdUnit");var ee=i((o,t)=>{var n;let e=(n=o.IDS)==null?void 0:n[0];if(e==null)return;let r=parseInt(e);isNaN(r)||(t.IDS=r)},"setUserTargetingOnPts"),re=i((o,t)=>{for(let e of ht)o[e]!=null&&(t[e]=o[e])},"setPageTargetingOnPts"),ne=i((o,t,e)=>{var u,h,f,m,tt,Y;let{adUnit:r}=o;if((r==null?void 0:r.id)==null)return;let n=r.id,s=kt((u=r.sizes)!=null?u:[]),g=r.position;for(let U of mt){let F=t[U];F!=null&&((h=e[U])!=null||(e[U]={}),(m=(f=e[U])[n])!=null||(f[n]={}),e[U][n][s]=F[0],g!=null&&((Y=(tt=e[U][n])[g])!=null||(tt[g]={}),e[U][n][g][s]=F[0]))}},"setSlotTargetingOnPts");var ve="legacy-api",oe="gpt",q=class extends L{_initialize(){this.core.get(k).setApi({loadSignals:this.loadSignals.bind(this),loadSignalsForSlots:this.loadSignalsForSlots.bind(this),getTargeting:this.getTargeting.bind(this)})}_setUserTargetingOnPts(t){let e=this.core.get(k).getPts();ee(t,e)}_setPageTargetingOnPts(t){let e=this.core.get(k).getPts();re(t,e)}_setSlotTargetingOnPts(t,e){let r=this.core.get(k).getPts();ne(t,e,r)}loadSignals(t,e){return S(this,null,function*(){yield this._onDvtagReady("loadSignals",e)})}loadSignalsForSlots(t,e,r){return S(this,null,function*(){let n=this.core.get(R),s=this.core.get(T);for(let u of t){let h=u.getSlotElementId(),f=s.getSlot(oe,h);f==null&&(f=s.createSlot(oe,h,ct(u),ut(u,m=>this._getPubAdsTargeting(m)))),n.getSlotTargeting(f)}let g=typeof e=="function"?e:r;yield this._onDvtagReady("loadSignalsForSlots",g)})}getTargeting(t,e){return S(this,null,function*(){var g;let r=this.core.get(R),n=this.core.get(T);for(let u of(g=t.adUnits)!=null?g:[]){let{elementId:h,adUnit:f}=te(u),m=n.createSlot(ve,h,f);r.getSlotTargeting(m)}let s=i(()=>e==null?void 0:e(void 0,this.core.get(k).getPts()),"callback");yield this._onDvtagReady("getTargeting",s)})}_getPubAdsTargeting(t){var e,r,n;return(n=(r=(e=this.core.window.googletag)==null?void 0:e.pubads)==null?void 0:r.call(e).getTargeting(t))!=null?n:[]}_onDvtagReady(t,e){return S(this,null,function*(){yield new Promise(r=>{this.core.window.dvtag.queueAdRequest({callback:()=>{try{e==null||e()}catch(n){}r()},timestamp:new Date().getTime(),timeout:750,internal:!0})})})}};i(q,"LegacyLayer"),a([v],q.prototype,"_initialize",1),a([y(R,"userTargetingUpdated")],q.prototype,"_setUserTargetingOnPts",1),a([y(R,"pageTargetingUpdated")],q.prototype,"_setPageTargetingOnPts",1),a([y(R,"slotTargetingUpdated")],q.prototype,"_setSlotTargetingOnPts",1),q=a([d],q);var Z=class extends L{_getEnabledSignals(){return"IDS"}};i(Z,"SignalsIds"),a([y(R,"getEnabledSignals")],Z.prototype,"_getEnabledSignals",1),Z=a([d],Z);var St="gpt",Ue=["impressionViewable","slotOnload","slotVisibilityChanged","rewardedSlotGranted","rewardedSlotClosed","rewardedSlotReady","slotRequested","slotRenderEnded","slotResponseReceived"],P=class{constructor(){l(this,"plugins",{googletagSlotDiscovered:()=>[],googletagSlotDestroyed:()=>[],slotRequested:()=>[],slotRenderEnded:()=>[],impressionViewable:()=>[],slotOnload:()=>[],slotVisibilityChanged:()=>[],slotResponseReceived:()=>[],rewardedSlotGranted:()=>[],rewardedSlotClosed:()=>[],rewardedSlotReady:()=>[]});l(this,"initialized",!1)}_initialize(){this.initialized||(this.initialized=!0,this._onPubAdsReady(t=>{this._addEventListeners(t),this._scanForSlots(t)}))}_onAdRequestQueued(t){this._onPubAdsReady(e=>{this._scanForSlots(e,t)})}_onSlotDiscovered(t){t.source===St&&this.plugins.googletagSlotDiscovered(t)}_onSlotDestroyed(t){t.source===St&&this.plugins.googletagSlotDestroyed(t)}_onSlotRequested(t,e,r){this.core.get(T).notifyAdRequested(t,r)}_addEventListeners(t){Ue.forEach(e=>{t.addEventListener(e,r=>{let{slot:n,isNewlyDetected:s}=this._maybeDiscoverSlot(r.slot);n!=null&&this.plugins[e](n,r,s)})})}_scanForSlots(t,e){return t.getSlots().map(r=>this._maybeDiscoverSlot(r,e))}_maybeDiscoverSlot(t,e){let r=this.core.get(T),n=!1,s=t.getSlotElementId(),g=r.getSlot(St,s),u=g==null?void 0:g.getVariable("SLOT_VARIABLE_KEY_GPT_REFERENCE"),h=u!=null&&u!==t;return(g==null||h)&&(g=r.createSlot(St,s,ct(t),ut(t,f=>this._getPubAdsTargeting(f))),g.setVariable("SLOT_VARIABLE_KEY_GPT_REFERENCE",t),n=!0),r.notifySlotScanned(g,e),{slot:g,isNewlyDetected:n}}_getPubAdsTargeting(t){var e,r,n;return(n=(r=(e=this.core.window.googletag)==null?void 0:e.pubads)==null?void 0:r.call(e).getTargeting(t))!=null?n:[]}_onPubAdsReady(t){var n,s,g,u;let e=this.core.window;e.googletag=(n=e.googletag)!=null?n:{},e.googletag.cmd=(s=e.googletag.cmd)!=null?s:[];let r=(u=(g=e.googletag).pubads)==null?void 0:u.call(g);r!=null?t(r):e.googletag.cmd.push(()=>{t(e.googletag.pubads())})}};i(P,"Googletag"),a([v],P.prototype,"_initialize",1),a([y(_,"adRequestQueued")],P.prototype,"_onAdRequestQueued",1),a([y(T,"slotDiscovered")],P.prototype,"_onSlotDiscovered",1),a([y(T,"slotDestroyed")],P.prototype,"_onSlotDestroyed",1),a([y(P,"slotRequested")],P.prototype,"_onSlotRequested",1),P=a([d],P);var Ot="qt_loaded",ie="pts_pid",se="pts_sid";var Lt=i(o=>[...new Set(o.filter($t).map(t=>t.toLowerCase()))],"getGreenlightSignal");var M=class extends L{_autoInsertPageId(){let t=this.core.get(A);this.core.get(T).setUptPageTargeting({[ie]:[t.getVisitUuid()]})}_autoInsertSlotId(t){t.setUptSlotTargeting({[se]:[t.uuid]})}_autoInsertGlobalTargeting(t){this.core.get(T).addUptPageTargeting({[Ot]:Lt(Object.keys(t))})}_autoInsertSlotTargeting(t,e){t.addUptSlotTargeting({[Ot]:Lt(Object.keys(e))})}};i(M,"SignalsAutoInsertion"),a([v],M.prototype,"_autoInsertPageId",1),a([y(T,"slotDiscovered")],M.prototype,"_autoInsertSlotId",1),a([y(R,"userTargetingUpdated"),y(R,"pageTargetingUpdated")],M.prototype,"_autoInsertGlobalTargeting",1),a([y(R,"slotTargetingUpdated")],M.prototype,"_autoInsertSlotTargeting",1),M=a([d,j(P)],M);var x={TYPE:"b1",COMMIT_HASH:"b2",ENTRY_MODULES:"b3",HOSTNAME:"b4",CTX:"b5",CMP:"b6",VISIT_ID:"b7",FEATURE_FLAGS:"b8",TAG_FORMAT:"b9",SAMPLE_INTERVAL:"d1",FLUSH_TO_PXSRV:"d2",_PLACEHOLDER_BLOB_10:"b10",_PLACEHOLDER_DOUBLE_3:"d3",_PLACEHOLDER_DOUBLE_4:"d4",_PLACEHOLDER_DOUBLE_5:"d5"},Tt=W(Q({},x),{LOG_LEVEL:"b11",MESSAGE:"b12",TRACE:"b13"}),gt=W(Q({},x),{AD_REQUEST_STATUS:"b11",AD_REQUEST_INDEX:"d6",AD_REQUEST_DELAY:"d7",INTEGRATION_STYLE:"b12"});var $=class{getWindow(){return this.core.window}getDocument(){return this.getWindow().document}getUserAgent(){var t,e;return(e=(t=this.getWindow().navigator)==null?void 0:t.userAgent)!=null?e:""}getPageUrl(){var t,e;return(e=(t=this.getWindow().location)==null?void 0:t.href)!=null?e:""}getHostname(){return new URL(this.getPageUrl()).hostname}getNavigator(){return this.getWindow().navigator}getPerformance(){var t;return(t=this.getWindow().performance)!=null?t:{}}getPerformanceTimeMs(){var t,e,r;return Math.floor((r=(e=(t=this.getPerformance()).now)==null?void 0:e.call(t))!=null?r:null)}};i($,"Environment"),$=a([d],$);var Pe="https://pub.doubleverify.com/dvtag/metrics/event.png",xe=1,we=1,O=class{constructor(){l(this,"sharedDataPoints");l(this,"sampleInterval",we)}_onAdRequestCompleted(t){if(t.index!==0)return;let{timeoutValue:e,onDvtagReadyCalled:r,callbackCalled:n}=t,s=n!=null?n-r:e;this.fireEvent("ad-request",{[gt.AD_REQUEST_STATUS]:t.status,[gt.AD_REQUEST_INDEX]:t.index,[gt.AD_REQUEST_DELAY]:s,[gt.INTEGRATION_STYLE]:t.internal?"legacy":"modern"},{sampleInterval:this.sampleInterval,flushToPxsrv:1})}_handleError(t){this.fireEvent("log",{[Tt.LOG_LEVEL]:"error",[Tt.MESSAGE]:t.message,[Tt.TRACE]:t.trace.join("=>")},{sampleInterval:xe,flushToPxsrv:0})}_getSharedDataPoints(){if(this.sharedDataPoints==null){let t=this.core.get(A),e=this.core.get(N),r=this.core.get($),{ctx:n,cmp:s,legacy:g}=t.getTagInfo(),u=r.getHostname(),h=t.getVisitUuid(),f=e.getShortCommitId();this.sharedDataPoints={[x.COMMIT_HASH]:f,[x.ENTRY_MODULES]:"",[x.VISIT_ID]:h,[x.TAG_FORMAT]:g?"legacy":"modern",[x.FEATURE_FLAGS]:"",[x.CTX]:n,[x.CMP]:s,[x.HOSTNAME]:u}}return this.sharedDataPoints}fireEvent(t,e,{sampleInterval:r=1,flushToPxsrv:n=0}={}){if(Math.random()>=1/r)return;e=W(Q(Q({},e),this._getSharedDataPoints()),{[x.TYPE]:t,[x.SAMPLE_INTERVAL]:r,[x.FLUSH_TO_PXSRV]:n});let s=new URL(Pe);for(let[g,u]of Object.entries(e))s.searchParams.set(g,u.toString());this._sendBeacon(s.href)}_sendBeacon(t){try{typeof(navigator==null?void 0:navigator.sendBeacon)=="function"?navigator.sendBeacon(t):new Image().src=t}catch(e){}}};i(O,"Events"),a([y(_,"adRequestCompleted")],O.prototype,"_onAdRequestCompleted",1),a([Mt],O.prototype,"_handleError",1),O=a([d],O);var E=(p=>(p[p.CurrentScript="b9"]="CurrentScript",p[p.ReadySlots="b10"]="ReadySlots",p[p.PrevReadySlots="b11"]="PrevReadySlots",p[p.SeenSlots="b12"]="SeenSlots",p[p.NotReadySlots="b13"]="NotReadySlots",p[p.UnknownSlots="b14"]="UnknownSlots",p[p.TrackerIndex="d6"]="TrackerIndex",p[p.BatchStart="d7"]="BatchStart",p[p.BatchEnd="d8"]="BatchEnd",p[p.NumTimeouts="d9"]="NumTimeouts",p[p.NumReadySlots="d10"]="NumReadySlots",p[p.NumPrevReadySlots="d11"]="NumPrevReadySlots",p[p.NumSeenSlots="d12"]="NumSeenSlots",p[p.NumNotReadySlots="d13"]="NumNotReadySlots",p[p.NumUnknownSlots="d14"]="NumUnknownSlots",p[p.NumAdRequestsQueued="d15"]="NumAdRequestsQueued",p[p.NumAdRequestsCompleted="d16"]="NumAdRequestsCompleted",p[p.NumInternalAdRequestsCompleted="d17"]="NumInternalAdRequestsCompleted",p[p.NumSlotsRequested="d18"]="NumSlotsRequested",p[p.NumSlotWithReducedTargeting="d19"]="NumSlotWithReducedTargeting",p[p.NumSlotsWithExtendedTargeting="d20"]="NumSlotsWithExtendedTargeting",p))(E||{}),ae="implcheck",De=1e-4,Ce=5e3,ke=5,w=class{constructor(){l(this,"enabled",!1);l(this,"internalAdRequestQueuedCount",0);l(this,"adRequestsQueuedCount",0);l(this,"adRequestsCompletedCount",0);l(this,"slotsRequestedCount",0);l(this,"timeoutCount",0);l(this,"trackersSent",0);l(this,"requestedSlots",[]);l(this,"batchStart",0);l(this,"batchTimeout",null);l(this,"_summarizeSlots",i(t=>{let e=[],r=[],n=[],s=[],g=[],u=0,h=0,f=0;for(let m of t)m.validTargeting===2?f+=1:m.validTargeting===1?h+=1:u+=1,m.isReady?e.push(m.elementId):m.wasReady?r.push(m.elementId):m.seen?n.push(m.elementId):m.known?s.push(m.elementId):g.push(m.elementId);return{ready:e,prevReady:r,seen:s,notReady:n,unknown:g,numExactTargeting:f,numExtendedTargeting:h,numReducedTargeting:u}},"_summarizeSlots"))}isDebugEnabled(){return!1}_initialize(){this.enabled=this.core.get(w).isDebugEnabled()||Math.random()<De}_onAdRequestQueued(t){this.enabled&&(this.adRequestsQueuedCount+=1,t.internal&&(this.internalAdRequestQueuedCount+=1))}_onSlotScanned(t,e){var r;this.enabled&&e!=null&&t.setVariable("AD_REQUEST_FIRST_SEEN",(r=t.getVariable("AD_REQUEST_FIRST_SEEN"))!=null?r:e.index)}_onAdRequestCompleted(t){this.enabled&&(this.core.get(T).getSlots().forEach(e=>{let r=e.getVariable("AD_REQUEST_FIRST_SEEN");r!=null&&r<=t.index&&(e.setVariable("WAS_READY",!0),e.setVariable("IS_READY",!0))}),this.adRequestsCompletedCount+=1,(t.status==="tag-timeout"||t.status==="queue-timeout")&&(this.timeoutCount+=1))}_onSlotRequested(t,e){var r,n;this.enabled&&(this.requestedSlots.push({elementId:t.elementId,wasReady:(r=t.getVariable("WAS_READY"))!=null?r:!1,isReady:(n=t.getVariable("IS_READY"))!=null?n:!1,seen:t.getVariable("AD_REQUEST_FIRST_SEEN")!=null,known:!e,validTargeting:t.validateAdServerTargeting()}),t.setVariable("IS_READY",!1),this.slotsRequestedCount+=1,this._scheduleTracker())}_sendTracker(){let{ready:t,prevReady:e,seen:r,notReady:n,unknown:s,numExtendedTargeting:g,numReducedTargeting:u}=this._summarizeSlots(this.requestedSlots),h={[E.ReadySlots]:t.join(),[E.PrevReadySlots]:e.join(),[E.SeenSlots]:r.join(),[E.NotReadySlots]:n.join(),[E.UnknownSlots]:s.join(),[E.TrackerIndex]:this.trackersSent,[E.BatchStart]:this.batchStart,[E.BatchEnd]:this._time(),[E.NumTimeouts]:this.timeoutCount,[E.NumReadySlots]:t.length,[E.NumPrevReadySlots]:e.length,[E.NumSeenSlots]:r.length,[E.NumNotReadySlots]:n.length,[E.NumUnknownSlots]:s.length,[E.NumAdRequestsQueued]:this.adRequestsQueuedCount,[E.NumAdRequestsCompleted]:this.adRequestsCompletedCount,[E.NumInternalAdRequestsCompleted]:this.internalAdRequestQueuedCount,[E.NumSlotsRequested]:this.slotsRequestedCount,[E.NumSlotWithReducedTargeting]:u,[E.NumSlotsWithExtendedTargeting]:g};this.core.get(w).fireEvent(h),this.requestedSlots.length=0,this.trackersSent+=1,this.trackersSent>=ke&&(this.enabled=!1)}fireEvent(t){this.core.get(w).isDebugEnabled()?console.log(ae,this.trackersSent,t):this.core.get(O).fireEvent(ae,t,{flushToPxsrv:1})}_scheduleTracker(){this.batchTimeout==null&&(this.batchStart=this._time(),this.batchTimeout=setTimeout(()=>{this._sendTracker(),this.batchTimeout=null},Ce))}_time(){return Math.floor(performance.now())}};i(w,"ImplementationValidator"),a([v],w.prototype,"_initialize",1),a([y(_,"adRequestQueued")],w.prototype,"_onAdRequestQueued",1),a([y(T,"slotScanned")],w.prototype,"_onSlotScanned",1),a([y(_,"adRequestCompleted")],w.prototype,"_onAdRequestCompleted",1),a([y(T,"slotRequested")],w.prototype,"_onSlotRequested",1),w=a([d],w);var B=class{constructor(){l(this,"initialized",!1);l(this,"size",0)}_initialize(){return S(this,null,function*(){if(yield Promise.resolve(),this.initialized)return;this.initialized=!0,this.core.dvtag.cmd instanceof Array||(this.core.dvtag.cmd=[]);let t=this.core.dvtag.cmd;this.core.dvtag.cmd={push:(...e)=>{for(let r of e)try{r()}catch(n){}return this.size+=e.length,this.size}},this.core.dvtag.cmd.push(...t)})}};i(B,"CommandBuffer"),a([v],B.prototype,"_initialize",1),B=a([d],B);var Nt="api",I=class{_defineSlot(t,e={}){this.core.get(T).createSlot(Nt,t,W(Q({},e),{sizes:rt(e.sizes)}))}};i(I,"DefineSlot"),a([J("defineSlot")],I.prototype,"_defineSlot",1),I=a([d],I);var G=class{_getTargeting(t){var r;let e=this.core.get(T);if(t==null)return e.getUptPageTargeting();{let n=e.getSlot(Nt,t);return(r=n==null?void 0:n.getUptTargeting())!=null?r:e.getUptPageTargeting()}}};i(G,"GetTargeting"),a([J("getTargeting")],G.prototype,"_getTargeting",1),G=a([d],G);var ot=class{};i(ot,"HouseHold"),ot=a([d,j(_),j(B),j(I),j(G),j(O)],ot);if(window.dvtag==null||window.dvtag._core==null)try{new st(Ut,window)}catch(o){}})();
