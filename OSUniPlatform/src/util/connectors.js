import { Connect, SimpleSigner } from 'uport-connect'


export let uport = new Connect('Open Source University', {
  clientId: '2oqUbXKBLPEBLcycWoMdJasWY5yLUS4Su8b',
  network: 'rinkeby',
  signer: SimpleSigner('18ac7c75b3a052d845365a449f361e045eee65988f27b17b354180fee1988405')
});


export const web3 = uport.getWeb3()
