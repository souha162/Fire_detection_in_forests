const user = require('../models/user')

const router = require('express').Router()

const User = require('../models/user')



router.get('/',(req,res)=>{
    User.find().then(users=>{
        res.status(200).json(users)
    }).catch(err=>{
        res.status(500).json({error: err.message})
    })
    
})


router.post('/register',(req,res)=>{
        User.findOne({email : req.body.email}).then(user=>{
            if(user){
                res.status(409).json({error:'Email already exist'})
            }else{
                const newUser = new User(req.body)
                newUser.save().then(user=>{
                    res.status(201).json(user)
                console.log('ok')
                }).catch(err=>{
                    res.status(500).json({error: err.message})
                    console.log('oussama')
                })
        
                }
        })
    
})


router.post('/login',(req,res)=>{
    User.findOne({email : req.body.email,password: req.body.password}).then(user=>{
        if(user){
            res.status(200).json(user)
        }else{
            res.status(401).json({error: 'Incorrect password or password '})
        }
    }).catch(err=>{
        res.status(500).json({error: err.message})
        
    })
    
})





 

module.exports = router;
